import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import 'orientation_lock.dart';

class VideoPlayerPreview extends StatefulWidget {
  final List<String> sources;

  const VideoPlayerPreview({
    Key? key,
    required this.sources,
  }) : super(key: key);

  @override
  State<VideoPlayerPreview> createState() => _VideoPlayerPreviewState();
}

class _VideoPlayerPreviewState extends State<VideoPlayerPreview> {
  VideoPlayerController? _controller;
  List<VideoPlayerController> _pendingDisposal = [];
  StateSetter? _dialogSetState;
  int _currentIndex = 0;
  bool _isFullscreenOpen = false;
  bool _fullscreenControlsVisible = true;
  Timer? _fullscreenControlsTimer;
  bool _isSwitchingSource = false;

  // Preloading state
  bool _isPreloading = false;
  int _preloadProgress = 0;
  int _preloadTotal = 0;
  int _preloadGeneration = 0;
  final Map<String, VideoPlayerController> _preloadedControllers = {};

  // Pause feature variables
  bool _isInPause = false;
  late ValueNotifier<int> _pauseSecondsNotifier;
  Timer? _pauseTimer;
  String pauseDescription = '';

  @override
  void initState() {
    super.initState();
    _pauseSecondsNotifier = ValueNotifier<int>(0);
    _initializeFirstSource();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameSources(oldWidget.sources, widget.sources)) {
      _initializeFirstSource();
    }
  }

  bool _sameSources(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// Check if a source is a pause entry (format: "pause:number:description") - description is optional
  bool _isPauseEntry(String source) {
    return source.toLowerCase().startsWith('pause:');
  }

  /// Extract the pause duration in seconds from a pause entry
  int? _extractPauseSeconds(String source) {
    if (!_isPauseEntry(source)) return null;
    try {
      final String numberPart = source.substring('pause:'.length).split(':')[0];
      return int.parse(numberPart);
    } catch (e) {
      return null;
    }
  }

  String _extractPauseDescription(String source) {
    if (!_isPauseEntry(source)) return '';
    final parts = source.split(':');
    return parts.length > 2 ? parts.sublist(2).join(':') : 'PAUSE';
  }

  /// Start pause countdown
  void _startPauseCountdown(int seconds) {
    _pauseTimer?.cancel();
    _isInPause = true;
    _pauseSecondsNotifier.value = seconds;

    // Update main view
    if (mounted) {
      setState(() {});
    }

    // Notify fullscreen dialog to rebuild if open
    if (_isFullscreenOpen && _dialogSetState != null) {
      _dialogSetState!(() {});
    }

    _pauseTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _pauseSecondsNotifier.value--;
      if (_pauseSecondsNotifier.value <= 0) {
        timer.cancel();
        _pauseTimer = null;
        // Move to next source after pause ends
        _switchToIndex(_currentIndex + 1, autoplay: true);
      }
    });
  }

  /// Cancel pause countdown and cleanup
  void _cancelPauseCountdown() {
    _pauseTimer?.cancel();
    _pauseTimer = null;
    _isInPause = false;
    _pauseSecondsNotifier.value = 0;
  }

  Future<void> _initializeFirstSource() async {
    // Bump generation to cancel any in-flight preload
    _preloadGeneration++;
    final int myGeneration = _preloadGeneration;

    _currentIndex = 0;
    _cancelPauseCountdown();

    // Detach and dispose all previously preloaded controllers
    final Map<String, VideoPlayerController> oldPreloaded = Map<String, VideoPlayerController>.from(_preloadedControllers);
    _preloadedControllers.clear();
    _controller?.removeListener(_onControllerChanged);
    _controller = null;
    for (final c in oldPreloaded.values) {
      c.removeListener(_onControllerChanged);
      await c.dispose();
    }
    for (final c in _pendingDisposal) {
      await c.dispose();
    }
    _pendingDisposal.clear();

    if (!mounted || _preloadGeneration != myGeneration) return;

    if (widget.sources.isEmpty) {
      setState(() {});
      return;
    }

    // Collect unique video sources (excluding pause entries)
    final List<String> uniqueVideoSources = widget.sources.where((s) => !_isPauseEntry(s)).toSet().toList();

    if (uniqueVideoSources.isEmpty) {
      // All sources are pauses — start directly without preloading
      if (mounted) setState(() {});
      await _switchToIndex(0, autoplay: false);
      return;
    }

    _isPreloading = true;
    _preloadProgress = 0;
    _preloadTotal = uniqueVideoSources.length;
    if (mounted) setState(() {});

    for (final String source in uniqueVideoSources) {
      if (!mounted || _preloadGeneration != myGeneration) return;

      final VideoPlayerController controller = _createControllerForSource(source);
      await controller.initialize();

      if (!mounted || _preloadGeneration != myGeneration) {
        await controller.dispose();
        return;
      }

      _preloadedControllers[source] = controller;
      _preloadProgress++;
      if (mounted) setState(() {});
    }

    if (!mounted || _preloadGeneration != myGeneration) return;

    _isPreloading = false;
    setState(() {});
    await _switchToIndex(0, autoplay: false);
  }

  Future<void> _switchToIndex(int index, {required bool autoplay}) async {
    if (widget.sources.isEmpty || _isSwitchingSource) return;

    final int normalizedIndex = index % widget.sources.length;
    final bool wrappedToStart = index != 0 && normalizedIndex == 0;
    final bool shouldAutoplay = autoplay && !wrappedToStart;
    final String source = widget.sources[normalizedIndex];

    // Check if this source is a pause entry
    if (_isPauseEntry(source)) {
      final int? pauseSeconds = _extractPauseSeconds(source);
      setState(() {
        pauseDescription = _extractPauseDescription(source);
      });
      if (pauseSeconds != null && pauseSeconds > 0) {
        _cancelPauseCountdown();
        _currentIndex = normalizedIndex;
        _startPauseCountdown(pauseSeconds);
        return;
      }
    }

    // Cancel any ongoing pause
    _cancelPauseCountdown();

    _isSwitchingSource = true;

    // Reuse a preloaded controller when available; otherwise create and initialize on the fly
    final VideoPlayerController nextController;
    if (_preloadedControllers.containsKey(source)) {
      nextController = _preloadedControllers[source]!;
      await nextController.seekTo(Duration.zero);
    } else {
      nextController = _createControllerForSource(source);
      await nextController.initialize();
    }

    final VideoPlayerController? previous = _controller;
    if (previous != null && previous != nextController) {
      previous.removeListener(_onControllerChanged);
      // Only dispose controllers that are not managed by the preloaded map
      if (!_preloadedControllers.containsValue(previous)) {
        if (_isFullscreenOpen) {
          _pendingDisposal.add(previous);
        } else {
          await previous.dispose();
        }
      }
    }

    // Ensure exactly one listener on the incoming controller
    nextController.removeListener(_onControllerChanged);
    nextController.addListener(_onControllerChanged);

    _controller = nextController;
    _currentIndex = normalizedIndex;

    if (shouldAutoplay) {
      await nextController.play();
      if (nextController.value.duration.inMilliseconds > 100) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!nextController.value.isPlaying) {
            nextController.play();
          }
        });
      }
    }

    _isSwitchingSource = false;
    if (!mounted) return;

    setState(() {});

    if (_isFullscreenOpen && _dialogSetState != null) {
      _dialogSetState!(() {});
    }
  }

  VideoPlayerController _createControllerForSource(String source) {
    final Uri uri = Uri.tryParse(source) ?? Uri.file(source);
    final bool isRemote = uri.scheme == 'http' || uri.scheme == 'https';
    if (kIsWeb || isRemote) {
      return VideoPlayerController.networkUrl(uri);
    }
    return VideoPlayerController.contentUri(uri);
  }

  void _onControllerChanged() {
    if (!mounted) return;

    final VideoPlayerController? controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    try {
      // Check if video has finished
      if (controller.value.duration > Duration.zero && controller.value.position >= controller.value.duration && !_isSwitchingSource && !_isInPause) {
        _switchToIndex(_currentIndex + 1, autoplay: true);
      }
    } catch (e) {
      // Ignore errors from disposed controllers
    }
  }

  String _formatDuration(Duration value) {
    final int totalSeconds = value.inSeconds;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;
    final int hours = totalSeconds ~/ 3600;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _togglePlayPause() {
    final VideoPlayerController? controller = _controller;
    if (controller == null) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  void _showFullscreenControls() {
    _fullscreenControlsTimer?.cancel();
    _fullscreenControlsVisible = true;
    _fullscreenControlsTimer = Timer(const Duration(seconds: 3), () {
      _fullscreenControlsVisible = false;
      if (_dialogSetState != null) {
        _dialogSetState!(() {});
      }
    });
    if (_dialogSetState != null) {
      _dialogSetState!(() {});
    }
  }

  Widget _buildVideoPlayerUI({required VideoPlayerController controller, required bool isFullscreen}) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final Duration duration = value.duration;
        final Duration position = value.position > duration ? duration : value.position;

        if (isFullscreen) {
          final double aspectRatio = value.aspectRatio == 0 ? 16 / 9 : value.aspectRatio;
          return MouseRegion(
            onHover: (_) => _showFullscreenControls(),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_fullscreenControlsVisible) {
                  _togglePlayPause();
                } else {
                  _showFullscreenControls();
                }
              },
              onPanDown: (_) => _showFullscreenControls(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          VideoPlayer(controller),
                        ],
                      ),
                    ),
                  ),
                  if (_fullscreenControlsVisible) ...[
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: _togglePlayPause,
                            ),
                            Expanded(
                              child: Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.white54,
                                min: 0,
                                max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1,
                                value: position.inMilliseconds.clamp(0, duration.inMilliseconds > 0 ? duration.inMilliseconds : 1).toDouble(),
                                onChanged: (double ms) {
                                  controller.seekTo(Duration(milliseconds: ms.toInt()));
                                },
                              ),
                            ),
                            Text(
                              '${_formatDuration(position)} / ${_formatDuration(duration)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: value.aspectRatio == 0 ? 16 / 9 : value.aspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(controller),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _togglePlayPause,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _togglePlayPause,
                  ),
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1,
                      value: position.inMilliseconds.clamp(0, duration.inMilliseconds > 0 ? duration.inMilliseconds : 1).toDouble(),
                      onChanged: (double ms) {
                        controller.seekTo(Duration(milliseconds: ms.toInt()));
                      },
                    ),
                  ),
                  Text('${_formatDuration(position)} / ${_formatDuration(duration)}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openFullscreen() async {
    final VideoPlayerController? controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    await OrientationLock.lockLandscape();
    _fullscreenControlsVisible = true;
    _showFullscreenControls();
    if (mounted) {
      setState(() {
        _isFullscreenOpen = true;
      });
    }

    try {
      await showDialog<void>(
        context: context,
        barrierColor: Colors.black,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, dialogSetState) {
              // Store reference to update dialog when video changes
              _dialogSetState = dialogSetState;

              // Show pause screen in fullscreen if paused
              if (_isInPause) {
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: SafeArea(
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _pauseSecondsNotifier,
                        builder: (context, pauseSeconds, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    pauseDescription,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                pauseSeconds.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              }

              return Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                  child: Center(
                    child: _controller != null ? _buildVideoPlayerUI(controller: _controller!, isFullscreen: true) : SizedBox.shrink(),
                  ),
                ),
              );
            },
          );
        },
      );
    } finally {
      _fullscreenControlsTimer?.cancel();
      await OrientationLock.unlock();
    }

    if (!mounted) return;

    setState(() {
      _isFullscreenOpen = false;
    });

    // Dispose all controllers that were queued while in fullscreen
    for (final controller in _pendingDisposal) {
      await controller.dispose();
    }
    _pendingDisposal.clear();
    _dialogSetState = null;
  }

  @override
  void dispose() {
    _cancelPauseCountdown();
    _controller?.removeListener(_onControllerChanged);
    // Only dispose current controller if it is not managed by the preloaded map
    if (_controller != null && !_preloadedControllers.containsValue(_controller)) {
      _controller?.dispose();
    }
    // Dispose all preloaded controllers
    for (final VideoPlayerController c in _preloadedControllers.values) {
      c.removeListener(_onControllerChanged);
      c.dispose();
    }
    _preloadedControllers.clear();
    // Dispose any pending non-preloaded controllers
    for (final controller in _pendingDisposal) {
      controller.dispose();
    }
    _pendingDisposal.clear();
    _dialogSetState = null;
    _fullscreenControlsTimer?.cancel();
    _pauseSecondsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullscreenOpen) {
      return const SizedBox.shrink();
    }

    // Show preloading progress before first playback
    if (_isPreloading) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  '$_preloadProgress / $_preloadTotal',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show pause screen if in pause mode
    if (_isInPause) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Center(
                child: ValueListenableBuilder<int>(
                  valueListenable: _pauseSecondsNotifier,
                  builder: (context, pauseSeconds, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              pauseDescription,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          pauseSeconds.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    }

    // Show video player if not paused
    if (_controller == null || !_controller!.value.isInitialized) {
      return const SizedBox.shrink();
    }

    final double aspectRatio = _controller!.value.aspectRatio == 0 ? 16 / 9 : _controller!.value.aspectRatio;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ValueListenableBuilder<VideoPlayerValue>(
                valueListenable: _controller!,
                builder: (context, value, child) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(_controller!),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _togglePlayPause,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: _controller!,
          builder: (context, value, child) {
            final Duration duration = value.duration;
            final Duration position = value.position > duration ? duration : value.position;
            return Row(
              children: [
                IconButton(
                  icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _togglePlayPause,
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1,
                    value: position.inMilliseconds.clamp(0, duration.inMilliseconds > 0 ? duration.inMilliseconds : 1).toDouble(),
                    onChanged: (double value) {
                      _controller?.seekTo(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
                Text('${_formatDuration(position)} / ${_formatDuration(duration)}'),
                IconButton(
                  icon: const Icon(Icons.fullscreen),
                  onPressed: _openFullscreen,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
