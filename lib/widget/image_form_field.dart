// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:flutter/material.dart';

class ImageFormField extends StatelessWidget {
  static final int MAX_FILESIZE = 10 * 1024 * 1024; // 10MB

  final TextEditingController controller;
  final Function() callback;
  final Function()? deleteCallback;
  final bool enabled;

  ImageFormField({
    Key? key,
    required this.controller,
    required this.callback,
    this.deleteCallback,
    this.enabled = true,
  }) : super(key: key);

  static void showFileTooBigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(context.i18n.uploadImageErrorTooBig),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                    (states) => primaryColor,
                  ),
                ),
                child: FittedBox(fit: BoxFit.contain, child: Text("OK")),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                }),
          ],
        );
      },
    );
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
                  hintText: context.i18n.picture,
                  labelText: context.i18n.picture,
                  border: OutlineInputBorder(),
                ),
                onTap: callback,
              ),
              if (enabled && controller.text.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: getImageActionButtons(context),
                  ),
                )
            ],
          ),
        ),
        if (enabled && controller.text.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: getImageActionButtons(context),
            ),
          ),
      ],
    );
  }

  List<Widget> getImageActionButtons(BuildContext context) {
    return [
      SizedBox(
        height: 42,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => Colors.grey,
            ),
          ),
          child: Text(context.i18n.uploadImage.toUpperCase()),
          onPressed: callback,
        ),
      ),
      if (deleteCallback != null && controller.text.isNotEmpty)
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
              child: Text(context.i18n.deleteImage.toUpperCase()),
              onPressed: deleteCallback,
            ),
          ),
        ),
    ];
  }
}
