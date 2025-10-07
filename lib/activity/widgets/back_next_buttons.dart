import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../widget/cancel_button.dart';

class BackNextButtons extends StatefulWidget {
  final Function() back;
  final Function() next;
  final Function()? onCancelled;
  final String nextButtonTitle;
  final bool hasChanges;

  BackNextButtons({
    Key? key,
    required this.back,
    required this.next,
    required this.nextButtonTitle,
    required this.hasChanges,
    this.onCancelled,
  }) : super(key: key);

  @override
  _BackNextButtonsState createState() => _BackNextButtonsState();
}

class _BackNextButtonsState extends State<BackNextButtons> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            child: Text(
              context.i18n.back,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
            onPressed: () => widget.back(),
          ),
          SizedBox(
            width: width * 0.005,
          ),
          ElevatedButton(
            key: Key(KEY_BUTTON_NEXT),
            child: Text(
              widget.nextButtonTitle.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: () => widget.next(),
          ),
          SizedBox(
            width: width * 0.005,
          ),
          CancelButton(
            callback: widget.onCancelled ?? () => context.beamBack(),
            hasChanges: widget.hasChanges,
          ),
        ],
      ),
    );
  }
}
