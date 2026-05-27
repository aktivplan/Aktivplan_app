import 'package:apt_api/api.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/video_player_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class VideoFormField extends StatefulWidget {
  final Function(MultipartFile? file) onUpdateFile;
  final String initialFileKey;
  final MultipartFile? initialVideoFile;

  const VideoFormField({
    Key? key,
    required this.onUpdateFile,
    this.initialFileKey = "",
    this.initialVideoFile,
  }) : super(key: key);

  @override
  State<VideoFormField> createState() => _VideoFormFieldState();
}

class _VideoFormFieldState extends State<VideoFormField> {
  MultipartFile? videoFile;
  String videoSource = "";
  TextEditingController controller = TextEditingController();
  final FileControllerApi fileControllerApi = FileControllerApi(apiClient);
  int _loadRequestId = 0;

  @override
  void initState() {
    super.initState();
    videoFile = widget.initialVideoFile;
    if (videoFile != null) {
      controller.text = videoFile!.filename ?? "";
    } else {
      _loadInitialVideo();
    }
  }

  @override
  void didUpdateWidget(covariant VideoFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFileKey != widget.initialFileKey) {
      _loadInitialVideo();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormFieldPadding(
          child: Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
                controller: controller,
                readOnly: true,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: context.i18n.video,
                  labelText: context.i18n.video,
                  border: OutlineInputBorder(),
                ),
                onTap: openFileExplorer,
              ),
              if (controller.text.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: getActionButtons(context),
                  ),
                )
            ],
          ),
        ),
        if (controller.text.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: getActionButtons(context),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (videoSource.isNotEmpty) VideoPlayerPreview(sources: [videoSource]),
      ],
    );
  }

  List<Widget> getActionButtons(BuildContext context) {
    return [
      SizedBox(
        height: 42,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => Colors.grey,
            ),
          ),
          child: Text(context.i18n.uploadVideo.toUpperCase()),
          onPressed: openFileExplorer,
        ),
      ),
      if (controller.text.isNotEmpty)
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 42,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => errorColor,
                ),
              ),
              child: Text(context.i18n.deleteVideo.toUpperCase()),
              onPressed: () {
                setState(() {
                  controller.clear();
                  videoFile = null;
                  videoSource = "";
                });
                widget.onUpdateFile(null);
              },
            ),
          ),
        ),
    ];
  }

  void openFileExplorer() async {
    try {
      final List<PlatformFile> _paths = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['mp4'],
          ))
              ?.files ??
          [];
      if (_paths.isEmpty) {
        return;
      }
      final PlatformFile _file = _paths.first;
      videoFile = _file.bytes != null
          ? MultipartFile.fromBytes(
              "videoFile",
              _file.bytes!,
              filename: _file.name,
            )
          : await MultipartFile.fromPath("videoFile", _file.path!, filename: _file.name);
      controller.text = _file.name;
      if (_file.path != null && _file.path!.isNotEmpty) {
        setState(() {
          videoSource = _file.path!;
        });
      }
      widget.onUpdateFile(videoFile);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
  }

  void _loadInitialVideo() {
    final int requestId = ++_loadRequestId;

    controller.clear();
    videoFile = null;
    setState(() {
      videoSource = "";
    });

    if (widget.initialFileKey.isEmpty) {
      return;
    }

    fileControllerApi.getFile(widget.initialFileKey).then((response) {
      if (!mounted || requestId != _loadRequestId) {
        return;
      }

      controller.text = response?.filename ?? "";
      setState(() {
        videoSource = response?.url ?? "";
      });
    }).catchError((error) {
      if (!mounted || requestId != _loadRequestId) {
        return;
      }

      print("Error fetching initial video file: $error");
    });
  }
}
