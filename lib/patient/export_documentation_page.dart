import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/form_field_padding.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../colors.dart';
import '../main.dart';

class ExportDocumentationPage extends StatefulWidget {
  final String id;
  final String type;
  ExportDocumentationPage({required this.id, this.type = "pdf"});

  @override
  _ExportDocumentationPageState createState() => _ExportDocumentationPageState();
}

class _ExportDocumentationPageState extends State<ExportDocumentationPage> with TraceablePageMixin {
  final exportApi = new ExportControllerApi(apiClient);
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final startDateController = MaskedTextController(mask: "00.00.0000");
  final endDateController = MaskedTextController(mask: "00.00.0000");
  final List<String> validPdfValues = ["END_OF_DOCUMENT", "WEEKLY"];
  final List<String> validCsvValues = ["NO_IDENTIFICATOR", "ID", "NAME"];
  String selectedOptionValue = "";
  String type = "";
  DateTime? startDate;
  DateTime? endDate;
  bool exporting = false;

  exportDocumentation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        exporting = true;
      });
      if (type == "csv") {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(
            category: EVENT_CATEGORY_DOWNLOAD,
            name: EVENT_NAME_DOWNLOAD_CSV,
            action: "Downloaded CSV File",
          ),
        );
        final CSVPostDTO csv = new CSVPostDTO()
          ..filename = titleController.text
          ..patientId = widget.id
          ..patientIdentificator = ExportPatientIdentificator.fromJson(selectedOptionValue)
          ..startDate = englishDateFormat.format(startDate!)
          ..endDate = englishDateFormat.format(endDate!);
        final PreparedReportDTO? response = await exportApi.createCSV(csv);
        launchUrlString(response!.url!);
      } else {
        MatomoTracker.instance.trackEvent(
          eventInfo: EventInfo(category: EVENT_CATEGORY_DOWNLOAD, name: EVENT_NAME_DOWNLOAD_PDF, action: "Downloaded PDF File"),
        );
        final ReportPostDTO report = new ReportPostDTO()
          ..title = titleController.text
          ..patientId = widget.id
          ..signOption = ExportSignOption.fromJson(selectedOptionValue)
          ..startDate = englishDateFormat.format(startDate!)
          ..endDate = englishDateFormat.format(endDate!);
        final PreparedReportDTO? response = await exportApi.createReport(report);
        launchUrlString(response!.url!);
      }
      setState(() {
        exporting = false;
      });
    }
  }

  Text getTextForValue(value) {
    switch (value) {
      case "END_OF_DOCUMENT":
        return Text(context.i18n.export_END_OF_DOCUMENT);
      case "WEEKLY":
        return Text(context.i18n.export_WEEKLY);
      case "NO_IDENTIFICATOR":
        return Text(context.i18n.export_NO_IDENTIFICATOR);
      case "ID":
        return Text(context.i18n.export_ID);
      case "NAME":
        return Text(context.i18n.export_NAME);
    }
    return Text("");
  }

  @override
  initState() {
    super.initState();
    type = widget.type;
    selectedOptionValue = type == "pdf" ? "END_OF_DOCUMENT" : "NO_IDENTIFICATOR";
  }

  @override
  void dispose() {
    titleController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: startDate, firstDate: DateTime(2015, 8), lastDate: endDate ?? DateTime(2100));
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
        startDateController.text = DateFormat('dd.MM.yyyy', 'de').format(startDate!);
      });
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: endDate ?? DateTime.now(), firstDate: startDate ?? DateTime(2015, 8), lastDate: DateTime(2100));
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
        endDateController.text = DateFormat('dd.MM.yyyy', 'de').format(endDate!);
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final userRepository = KiwiContainer().resolve<UserRepository>();
    final userRole = userRepository.userRole;
    return ResponsiveBuilder(builder: (context, size) {
      double containerWidth = size.isMobile
          ? width * 0.95
          : size.isTablet
              ? width * 0.85
              : width * 0.6;
      double dateWidth = containerWidth * 0.45;
      return Center(
        heightFactor: 1.1,
        child: SingleChildScrollView(
          child: Container(
            width: containerWidth,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormFieldPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(type == 'csv' ? context.i18n.csvExport : context.i18n.documentation, style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  FormFieldPadding(
                    child: TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return context.i18n.validationNotEmpty;
                        } else if (value!.length < 2 || value.length > 100) {
                          return context.i18n.validationDefaultLength;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: type == 'csv' ? context.i18n.filename : context.i18n.documentTitle,
                        labelText: type == 'csv' ? context.i18n.filename : context.i18n.documentTitle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  if (!size.isMobile)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: dateWidth,
                          child: FormFieldPadding(
                            child: TextFormField(
                              controller: startDateController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if ((value ?? "").replaceAll(".", "").length < 8) {
                                  return context.i18n.validationInvalidValue;
                                }
                                return null;
                              },
                              onChanged: (val) {
                                String valueWithoutDots = val.replaceAll(".", "");
                                if (valueWithoutDots.length == 8) {
                                  startDate = DateTime.utc(int.parse(valueWithoutDots.substring(4)), int.parse(valueWithoutDots.substring(2, 4)),
                                      int.parse(valueWithoutDots.substring(0, 2)));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: context.i18n.exportStartDate,
                                labelText: context.i18n.exportStartDate,
                                border: OutlineInputBorder(),
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.date_range),
                                  color: lightTextColor,
                                  onPressed: () => _selectStartDate(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FormFieldPadding(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16),
                              Icon(Icons.remove),
                            ],
                          ),
                        ),
                        Container(
                          width: dateWidth,
                          child: FormFieldPadding(
                            child: TextFormField(
                              controller: endDateController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if ((value ?? "").replaceAll(".", "").length < 8) {
                                  return context.i18n.validationInvalidValue;
                                }
                                return null;
                              },
                              onChanged: (val) {
                                String valueWithoutDots = val.replaceAll(".", "");
                                if (valueWithoutDots.length == 8) {
                                  endDate = DateTime.utc(int.parse(valueWithoutDots.substring(4)), int.parse(valueWithoutDots.substring(2, 4)),
                                      int.parse(valueWithoutDots.substring(0, 2)));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: context.i18n.exportEndDate,
                                labelText: context.i18n.exportEndDate,
                                border: OutlineInputBorder(),
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.date_range),
                                  color: lightTextColor,
                                  onPressed: () => _selectEndDate(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (size.isMobile)
                    Column(
                      children: [
                        FormFieldPadding(
                          child: TextFormField(
                            controller: startDateController,
                            readOnly: true,
                            validator: (value) => (value ?? "").isEmpty ? context.i18n.validationInvalidValue : null,
                            decoration: InputDecoration(
                              hintText: context.i18n.exportStartDate,
                              labelText: context.i18n.exportStartDate,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: lightTextColor,
                              ),
                            ),
                            onTap: () => _selectStartDate(context),
                          ),
                        ),
                        FormFieldPadding(
                          child: TextFormField(
                            controller: endDateController,
                            readOnly: true,
                            validator: (value) => (value ?? "").isEmpty ? context.i18n.validationInvalidValue : null,
                            decoration: InputDecoration(
                              hintText: context.i18n.exportEndDate,
                              labelText: context.i18n.exportEndDate,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: lightTextColor,
                              ),
                            ),
                            onTap: () => _selectEndDate(context),
                          ),
                        ),
                      ],
                    ),
                  FormFieldPadding(
                    child: DropdownButtonFormField(
                      initialValue: selectedOptionValue,
                      onChanged: (value) {
                        setState(() {
                          selectedOptionValue = value?.toString() ?? "";
                        });
                      },
                      decoration: InputDecoration(
                          hintText: type == 'csv' ? context.i18n.identificator : context.i18n.signature,
                          labelText: type == 'csv' ? context.i18n.identificator : context.i18n.signature,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                      validator: (value) => value == null ? context.i18n.validationNotEmpty : null,
                      items: (type == 'csv' ? validCsvValues : validPdfValues).map((value) {
                        return DropdownMenuItem<String>(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [getTextForValue(value)],
                          ),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                  FormFieldPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        exporting
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : SaveButton(
                                title: context.i18n.export.toUpperCase(),
                                callback: exportDocumentation,
                              ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        if (!exporting && userRole != UserRole.PATIENT)
                          CancelButton(
                            callback: () => context.beamBack(),
                            hasChanges: false,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoIconColor,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: SelectableText(
                            context.i18n.exportHint,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 1.1, color: infoIconColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String get traceablePageName => "Export Documentation Page";
}
