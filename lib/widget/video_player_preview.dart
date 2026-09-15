// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoPlayerPreview extends StatefulWidget {
  final List<String> sources;
  final List<int> pauseIndizes;
  final int initialIndex;

  const VideoPlayerPreview({
    Key? key,
    required this.sources,
    this.pauseIndizes = const [],
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<VideoPlayerPreview> createState() => _VideoPlayerPreviewState();
}

class _VideoPlayerPreviewState extends State<VideoPlayerPreview> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  int _currentIndex = 0;
  int? _failedIndex;
  bool _isSwitchingSource = false;

  bool _isDisposed = false;
  bool _isLoadingVideo = false;
  String? _videoLoadError;
  final Map<String, VideoPlayerController> _preloadedControllers = {};

  // Pause feature variables
  bool _isInPause = false;
  late ValueNotifier<int> _pauseSecondsNotifier;
  Timer? _pauseTimer;
  String pauseDescription = '';

  // Custom fullscreen
  bool _isCustomFullScreen = false;
  OverlayEntry? _overlayEntry;

  // Track pending play operations to avoid "play() request was interrupted" errors
  Timer? _pendingPlayTimer;

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
    } else if (oldWidget.initialIndex != widget.initialIndex && widget.initialIndex >= 0 && widget.initialIndex < widget.sources.length) {
      _switchToIndex(widget.initialIndex, autoplay: true);
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
    _overlayEntry?.markNeedsBuild();

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
    WakelockPlus.enable();
    // Bump generation to cancel any in-flight preload
    _currentIndex = 0;
    _failedIndex = null;
    _videoLoadError = null;
    _isLoadingVideo = false;
    _cancelPauseCountdown();

    // Detach and dispose all previously preloaded controllers
    _controller?.removeListener(_onControllerChanged);
    _controller = null;
    final ChewieController? oldChewie = _chewieController;
    _chewieController = null;
    oldChewie?.dispose();
    List<String> oldKeys = _preloadedControllers.keys.toList();
    for (String key in oldKeys) {
      if (!widget.sources.contains(key)) {
        _disposeController(_preloadedControllers[key]!).ignore();
        _preloadedControllers.remove(key);
      }
    }

    if (!mounted) return;

    if (widget.sources.isEmpty) {
      setState(() {});
      return;
    }

    if (widget.sources.every(_isPauseEntry)) {
      if (mounted) setState(() {});
      await _switchToIndex(0, autoplay: false);
      return;
    }

    if (!mounted) return;
    await _switchToIndex(0, autoplay: false);
  }

  void _notifyUiChanged() {
    if (mounted) {
      setState(() {});
    }
    _overlayEntry?.markNeedsBuild();
  }

  Future<void> _disposeController(VideoPlayerController controller) async {
    controller.removeListener(_onControllerChanged);
    await controller.dispose();
  }

  Future<VideoPlayerController?> _initializeController(
    String source, {
    bool reportErrors = true,
  }) async {
    final VideoPlayerController? reusedController = _preloadedControllers[source] ?? null;
    if (reusedController != null) {
      return reusedController;
    }

    final VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(source));
    try {
      await controller.initialize().timeout(const Duration(seconds: 60));
      _preloadedControllers[source] = controller;
      return controller;
    } on TimeoutException {
      await _disposeController(controller);
      if (reportErrors) {
        _videoLoadError = 'Loading the video timed out. Please try again.';
      }
      return null;
    } catch (_) {
      await _disposeController(controller);
      if (reportErrors) {
        _videoLoadError = 'This video could not be loaded on this device.';
      }
      return null;
    }
  }

  Future<void> _retryFailedSource() async {
    final int retryIndex = _failedIndex ?? _currentIndex;
    await _switchToIndex(retryIndex, autoplay: false);
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
      _overlayEntry?.markNeedsBuild();
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
    _isLoadingVideo = true;
    _failedIndex = null;
    _videoLoadError = null;
    _notifyUiChanged();

    // Reuse a preloaded controller when available; otherwise create and initialize on the fly
    final VideoPlayerController? nextController = await _initializeController(source);
    if (nextController == null) {
      _isSwitchingSource = false;
      _isLoadingVideo = false;
      _failedIndex = normalizedIndex;
      _notifyUiChanged();
      return;
    }

    await nextController.seekTo(Duration.zero);

    final VideoPlayerController? previous = _controller;
    if (previous != null && previous != nextController) {
      previous.removeListener(_onControllerChanged);
      // Only dispose controllers that are not managed by the preloaded map
      if (!_preloadedControllers.containsValue(previous)) {
        await previous.dispose();
      }
    }

    // Ensure exactly one listener on the incoming controller
    nextController.removeListener(_onControllerChanged);
    nextController.addListener(_onControllerChanged);

    _controller = nextController;
    final ChewieController? oldChewie = _chewieController;
    _chewieController = ChewieController(
      videoPlayerController: nextController,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      hideControlsTimer: Duration(milliseconds: 500),
      showControlsOnInitialize: false,
    );
    oldChewie?.dispose();
    _currentIndex = normalizedIndex;
    _failedIndex = null;
    _videoLoadError = null;
    _isLoadingVideo = false;

    if (shouldAutoplay) {
      _pendingPlayTimer?.cancel();
      _pendingPlayTimer = Timer(const Duration(milliseconds: 100), () {
        if (_isDisposed || !mounted) return;
        // Only play if this controller is still the active one
        if (_controller != nextController) return;
        try {
          if (!nextController.value.isPlaying) {
            nextController.play();
          }
        } catch (_) {
          // Ignore errors from controllers that were disposed in the meantime
        }
      });
    }

    _isSwitchingSource = false;
    _notifyUiChanged();
  }

  // ── Custom fullscreen (Overlay-based — survives video switches) ───────────

  void _exitFullScreen() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    if (!_isDisposed && mounted) setState(() => _isCustomFullScreen = false);
  }

  void _enterFullScreen() {
    if (_isDisposed || !mounted) return;
    if (_controller == null && !_isInPause) return;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _overlayEntry = OverlayEntry(builder: (_) => _buildFullscreenContent());
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isCustomFullScreen = true);
  }

  /// The content rendered inside the fullscreen overlay.
  /// Reads state directly from `this`, so [OverlayEntry.markNeedsBuild] keeps
  /// it in sync whenever the parent calls [_notifyUiChanged].
  Widget _buildFullscreenContent() {
    final Widget content;
    if (_isLoadingVideo) {
      content = const Center(child: CircularProgressIndicator(color: Colors.white));
    } else if (_isInPause) {
      content = Center(child: _buildPauseCountdown());
    } else if (_chewieController != null) {
      content = Chewie(controller: _chewieController!);
    } else {
      content = const SizedBox.shrink();
    }
    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            content,
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNavigationButtons(isFullScreen: true),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.fullscreen_exit, color: Colors.white, size: 28),
                    onPressed: _exitFullScreen,
                    style: IconButton.styleFrom(backgroundColor: Colors.black45),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullscreenButton() {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.fullscreen, color: Colors.white),
        onPressed: _enterFullScreen,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        iconSize: 24,
      ),
    );
  }

  /// Shared pause countdown widget used in both the normal and fullscreen views.
  Widget _buildPauseCountdown() {
    return ValueListenableBuilder<int>(
      valueListenable: _pauseSecondsNotifier,
      builder: (context, seconds, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  pauseDescription,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              seconds.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────

  void _onControllerChanged() {
    if (_isDisposed) return;

    final VideoPlayerController? controller = _controller;
    if (controller == null) return;

    // Guard against callbacks from a controller that has already been replaced
    if (!_preloadedControllers.containsValue(controller) && controller != _controller) {
      return;
    }

    final VideoPlayerValue value;
    try {
      value = controller.value;
    } catch (_) {
      // Controller may have been disposed between the check and the access
      return;
    }

    if (value.hasError) {
      if (_videoLoadError != null) return; // Only handle first error
      _videoLoadError = value.errorDescription ?? 'Playback failed on this device.';
      _failedIndex = _currentIndex;
      _isLoadingVideo = false;
      _notifyUiChanged();
      return;
    }

    if (value.isCompleted && !_isSwitchingSource && !_isInPause) {
      final int nextIndex = _currentIndex + 1;
      if (nextIndex < widget.sources.length) {
        _switchToIndex(nextIndex, autoplay: true);
      }
      // Last source reached: stay at end, keep controllers alive
    }
  }

  void _jumpToPreviousSection() {
    if (_isSwitchingSource || _isDisposed) return;
    int prevIndex = 0;
    if (widget.pauseIndizes.isNotEmpty) {
      // Find the last index that is strictly less than the current one
      try {
        prevIndex = widget.pauseIndizes.lastWhere((idx) => idx < _currentIndex);
      } catch (e) {
        prevIndex = 0;
      }
    }
    _switchToIndex(prevIndex, autoplay: true);
  }

  void _jumpToNextSection() {
    if (_isSwitchingSource || _isDisposed) return;
    if (widget.pauseIndizes.isEmpty) return;
    int nextIndex = -1;
    try {
      nextIndex = widget.pauseIndizes.firstWhere((idx) => idx > _currentIndex);
    } catch (e) {
      nextIndex = -1;
    }

    if (nextIndex != -1) {
      _switchToIndex(nextIndex, autoplay: true);
    }
  }

  bool _hasNextSection() {
    if (widget.pauseIndizes.isEmpty) return false;
    return widget.pauseIndizes.any((idx) => idx > _currentIndex);
  }

  Widget _buildNavigationButtons({bool isFullScreen = false}) {
    if (widget.pauseIndizes.isEmpty && widget.sources.length <= 1) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
          child: IconButton(
            icon: const Icon(Icons.skip_previous, color: Colors.white),
            onPressed: _jumpToPreviousSection,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            iconSize: 24,
          ),
        ),
        const SizedBox(width: 8),
        if (_hasNextSection())
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.skip_next, color: Colors.white),
              onPressed: _jumpToNextSection,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              iconSize: 24,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    WakelockPlus.disable();
    _exitFullScreen();
    _cancelPauseCountdown();
    _pendingPlayTimer?.cancel();
    _pendingPlayTimer = null;
    final ChewieController? chewie = _chewieController;
    _chewieController = null;
    chewie?.dispose();
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
    _pauseSecondsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Intercept back-button while fullscreen is active.
    return PopScope(
      canPop: !_isCustomFullScreen,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exitFullScreen();
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    // While the fullscreen overlay is active show a plain black placeholder so
    // the normal widget tree doesn't also try to render the ChewieController.
    if (_isCustomFullScreen) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(color: Colors.black),
      );
    }

    if (_videoLoadError != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 40),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _videoLoadError!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _retryFailedSource,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_isLoadingVideo) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    // Show pause screen if in pause mode
    if (_isInPause) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Center(child: _buildPauseCountdown()),
              Positioned(
                top: 8,
                right: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavigationButtons(),
                    const SizedBox(width: 8),
                    _buildFullscreenButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show video player if not paused
    if (_chewieController == null) {
      return const SizedBox.shrink();
    }

    final double aspectRatio = _controller!.value.aspectRatio == 0 ? 16 / 9 : _controller!.value.aspectRatio;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Stack(
        children: [
          Chewie(controller: _chewieController!),
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavigationButtons(),
                const SizedBox(width: 8),
                _buildFullscreenButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
