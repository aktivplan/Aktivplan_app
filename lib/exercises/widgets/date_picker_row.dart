import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DatePickerRow extends StatefulWidget {
  final Function selectDate;
  final DateTime? startDate;
  final String? labelText;
  final DateTime? firstDate;
  final bool isRequired;
  final bool selected;
  final bool disabled;

  DatePickerRow(
      {Key? key,
      required this.selectDate,
      this.startDate,
      this.labelText,
      this.firstDate,
      this.isRequired = true,
      this.selected = false,
      this.disabled = false})
      : super(key: key);

  @override
  _DatePickerRowState createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  final startDateController = MaskedTextController(mask: "00.00.0000");
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    startDateController.text = widget.startDate != null ? DateFormat('dd.MM.yyyy', 'de').format(widget.startDate!) : "";
  }

  @override
  void dispose() {
    startDateController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DatePickerRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startDate != oldWidget.startDate) {
      startDateController.text = widget.startDate != null ? DateFormat('dd.MM.yyyy', 'de').format(widget.startDate!) : "";
    }
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: startDate ?? DateTime.now(), firstDate: widget.firstDate ?? DateTime(2015, 8), lastDate: DateTime(2100));

    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
        startDateController.text = DateFormat('dd.MM.yyyy', 'de').format(startDate!);
      });
    widget.selectDate(startDate);
  }

  parseToGermanFormat(String date) {
    return date.substring(0, 2) + "." + date.substring(2, 4) + "." + date.substring(4, 8);
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
                controller: startDateController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return widget.isRequired ? context.i18n.validationNotEmpty : null;
                  } else if (value!.length != 10) {
                    return context.i18n.validationInvalidValue;
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  String valueWithoutDots = val.replaceAll(".", "");
                  if (valueWithoutDots.length == 8) {
                    setState(() {
                      String date = parseToGermanFormat(valueWithoutDots);
                      startDate = germanDateFormat.parse(date);
                      widget.selectDate(startDate);
                    });
                  }
                },
                decoration: InputDecoration(
                  fillColor: (widget.disabled ? infoIconColor : primaryColor).withOpacity(.2),
                  filled: widget.selected,
                  hintText: widget.labelText ?? context.i18n.startDate,
                  labelText: (widget.labelText ?? context.i18n.startDate) + (widget.isRequired ? " *" : ""),
                  labelStyle: TextStyle(
                    color: widget.selected && !widget.disabled ? primaryColor : lightTextColor,
                  ),
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    color: widget.selected && !widget.disabled ? primaryColor : lightTextColor,
                    onPressed: () => _selectStartDate(context),
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
