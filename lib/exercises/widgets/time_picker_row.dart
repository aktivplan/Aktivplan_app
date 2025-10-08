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
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TimePickerRow extends StatefulWidget {
  final Function selectTime;
  final String initialTime;
  final bool requiredField;
  final bool selected;
  final bool disabled;

  TimePickerRow({Key? key, required this.selectTime, this.initialTime = "", this.requiredField = false, this.selected = false, this.disabled = false})
      : super(key: key);

  @override
  _TimePickerRowState createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> {
  final timeController = MaskedTextController(mask: "00:00");
  final timeFormat = DateFormat('HH:mm');
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();
    timeController.text = widget.initialTime;
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TimePickerRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTime != oldWidget.initialTime) {
      timeController.text = widget.initialTime;
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null && picked != time)
      setState(() {
        time = picked;
        timeController.text = timeFormat.format(DateTime.now().setHour(time!.hour).setMinute(time!.minute));
      });
    widget.selectTime(timeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                style: widget.selected
                    ? TextStyle(
                        color: !widget.disabled ? primaryColor : lightTextColor,
                        fontWeight: FontWeight.bold,
                      )
                    : null,
                enabled: !widget.disabled,
                controller: timeController,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
                validator: (value) {
                  if ((value ?? "").isEmpty && widget.requiredField) {
                    return context.i18n.validationNotEmpty;
                  } else if ((value ?? "").isNotEmpty && value!.length != 5) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  if (val.length == 2 && int.parse(val) > 23) {
                    timeController.text = "00";
                  } else if (val.length == 5) {
                    if (int.parse(val.substring(3)) > 59) {
                      timeController.text = val.substring(0, 2) + ":00";
                    }
                    widget.selectTime(timeController.text);
                  } else if (val.isEmpty && !widget.requiredField) {
                    widget.selectTime("");
                  }
                },
                decoration: InputDecoration(
                  fillColor: (widget.disabled ? infoIconColor : primaryColor).withOpacity(.2),
                  filled: widget.selected,
                  hintText: context.i18n.time,
                  labelText: context.i18n.time + (widget.requiredField ? " *" : ""),
                  labelStyle: TextStyle(
                    color: widget.selected && !widget.disabled ? primaryColor : lightTextColor,
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.schedule),
                    color: widget.selected && !widget.disabled ? primaryColor : lightTextColor,
                    onPressed: () => _selectTime(context),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.selected ? primaryColor : datatableBorderColor,
                      width: widget.selected ? 2 : 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
