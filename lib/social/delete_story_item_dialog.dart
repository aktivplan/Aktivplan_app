import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';

class DeleteStoryItemDialog extends StatelessWidget {
  final String statusFileId;
  final FlutterStoryController storyController;

  DeleteStoryItemDialog({Key? key, required this.statusFileId, required this.storyController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialBloc socialBloc = BlocProvider.of<SocialBloc>(context);
    return AlertDialog(
      title: Text(
        context.i18n.removeStoryItemConfirmTitle,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        context.i18n.removeStoryItemConfirmText,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // INFO resume story
            storyController.play();
            Navigator.of(context).pop();
          },
          child: Text(context.i18n.cancel),
        ),
        TextButton(
          onPressed: () {
            socialBloc.add(RemoveStoryItemEvent(fileId: statusFileId));
            Navigator.of(context).pop();
          },
          child: Text(context.i18n.delete),
        ),
      ],
    );
  }
}
