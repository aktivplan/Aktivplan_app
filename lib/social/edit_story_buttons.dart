import 'package:aptapp/social/delete_story_item_dialog.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';

class EditStoryButtons extends StatefulWidget {
  final String statusFileId;
  final FlutterStoryController storyController;

  EditStoryButtons({Key? key, required this.statusFileId, required this.storyController}) : super(key: key);

  @override
  _EditStoryButtonsState createState() => _EditStoryButtonsState();
}

class _EditStoryButtonsState extends State<EditStoryButtons> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    double radius = 28;
    double radiusMini = 24;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: _isExpanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: radiusMini,
                    backgroundColor: Color(Colors.white.toARGB32()),
                    child: IconButton(
                      onPressed: () => context.beamToNamed('/contacts/my-story/add-message'),
                      icon: Icon(Icons.text_format),
                    ),
                  ),
                  SizedBox(width: 5),
                  if (!kIsWeb)
                    CircleAvatar(
                      radius: radiusMini,
                      backgroundColor: Color(Colors.white.toARGB32()),
                      child: IconButton(
                        onPressed: () => context.beamToNamed('/contacts/my-story/add-pictures'),
                        icon: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            radius: radius,
            backgroundColor: Color(Colors.white.toARGB32()),
            child: IconButton(
              onPressed: _toggleExpand,
              icon: Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          CircleAvatar(
            radius: radius,
            backgroundColor: Color(Colors.white.toARGB32()),
            child: IconButton(
              onPressed: () {
                widget.storyController.pause();
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => DeleteStoryItemDialog(
                    statusFileId: widget.statusFileId,
                    storyController: widget.storyController,
                  ),
                );
              },
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
