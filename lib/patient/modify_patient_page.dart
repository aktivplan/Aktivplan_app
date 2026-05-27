import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/exercises/widgets/time_picker_row.dart';
import 'package:aptapp/institution/bloc/institution_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/activity_classes_page.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/user/user_controller_repository.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/image_form_field.dart';
import 'package:aptapp/widget/location_picker.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:styled_text/styled_text.dart';

import '../apt_layout.dart';
import '../colors.dart';
import '../main.dart';
import '../theme.dart';
import '../widget/form_field_padding.dart';
import 'bloc/mail_bloc.dart';
import 'bloc/mail_event.dart';
import 'bloc/mail_state.dart';

class ModifyPatientPage extends StatefulWidget {
  final bool edit;
  final PatientGetDTO? patient;
  final String? healthcareProfessionalId;
  final String? userId;
  final String? institutionId;

  ModifyPatientPage({
    Key? key,
    required this.edit,
    this.patient,
    this.userId,
    this.healthcareProfessionalId,
    this.institutionId,
  }) : super(key: key);

  @override
  _ModifyPatientPageState createState() => _ModifyPatientPageState();
}

class _ModifyPatientPageState extends State<ModifyPatientPage> with TraceablePageMixin {
  final _addPatientFormKey = GlobalKey<FormState>();
  final participantIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdayController = MaskedTextController(mask: "00.00.0000");
  final surgeryDateController = MaskedTextController(mask: "00.00.0000");
  String surgeryTime = "";
  final heightController = TextEditingController(); //numeric
  final weightController = TextEditingController(); //numeric
  int? activityValue = 0;
  final heartrateController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final performanceController = TextEditingController();
  final oxygenController = TextEditingController();
  final diseaseController = TextEditingController();
  final medicationController = TextEditingController();
  final photoController = TextEditingController();
  UserBloc? userBloc;
  FileGetDTO? userPicture;
  String uploadedPicturePath = "";
  InstitutionDTO? institution;

  MultipartFile? profilePicture;
  bool acceptedTerms = false;
  bool duplicateMail = false;
  final userRepository = KiwiContainer().resolve<UserRepository>();
  final userApi = new UserControllerApi(apiClient);
  PatientGetDTO? patient;

  LocationDTO? homeLocation;
  String homeLocationAddress = "";
  LocationDTO? workLocation;
  String workLocationAddress = "";
  HeatTolerance heatTolerance = HeatTolerance.AVERAGE;
  MultiSelectController<MobilityPreference> mobilityPreferencesController = MultiSelectController();
  MultiSelectController<MobilityPreference> dislikedMobilityPreferencesController = MultiSelectController();
  List<DropdownItem<MobilityPreference>> mobilityPreferencesItems = [];
  List<DropdownItem<MobilityPreference>> dislikedMobilityPreferencesItems = [];
  bool syncingMobilityProperties = false;
  MultiSelectController<PredefinedActivityType> preferredActivityTypesController = MultiSelectController();
  MultiSelectController<PredefinedActivityType> dislikedActivityTypesController = MultiSelectController();
  List<DropdownItem<PredefinedActivityType>> preferredActivityTypesItems = [];
  List<DropdownItem<PredefinedActivityType>> dislikedActivityTypesItems = [];
  bool syncingPredefinedActivityProperties = false;

  static const int MIN_HEIGHT = 100;
  static const int MAX_HEIGHT = 230;
  static const int MIN_WEIGHT = 30;
  static const int MAX_WEIGHT = 250;
  static const int MIN_HEARTRATE = 60;
  static const int MAX_HEARTRATE = 220;
  static const int MIN_SYSTOLIC = 100;
  static const int MAX_SYSTOLIC = 300;
  static const int MIN_DIASTOLIC = 50;
  static const int MAX_DIASTOLIC = 200;
  static const double MIN_PERFORMANCE = 0.1;
  static const int MAX_PERFORMANCE = 8;
  static const int MIN_OXYGEN = 10;
  static const int MAX_OXYGEN = 100;

  String homeLocationErrorLabel = "";
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);

    if (userRepository.userRole == UserRole.ADMINISTRATOR) {
      KiwiContainer().resolve<InstitutionRepository>().getInstitutionbyId(id: widget.institutionId!).then((value) {
        setState(() {
          institution = value;
        });
      });
    } else {
      institution = userRepository.user!.institution!;
    }

    // delay to gather the context for translations
    Future.delayed(Duration.zero, () {
      mobilityPreferencesItems = MobilityPreference.values
          .map((e) => DropdownItem(
                label: e.getTranslatedText(context),
                value: e,
              ))
          .toList();
      dislikedMobilityPreferencesItems = MobilityPreference.values
          .map((e) => DropdownItem(
                label: e.getTranslatedText(context),
                value: e,
              ))
          .toList();
      preferredActivityTypesItems = PredefinedActivityType.values
          .where((e) => e != PredefinedActivityType.OTHER)
          .map((e) => DropdownItem(
                label: e.getTranslatedText(context),
                value: e,
              ))
          .toList();
      dislikedActivityTypesItems = PredefinedActivityType.values
          .where((e) => e != PredefinedActivityType.OTHER)
          .map((e) => DropdownItem(
                label: e.getTranslatedText(context),
                value: e,
              ))
          .toList();
      getPatient();
    });
  }

  @override
  void dispose() {
    participantIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    surgeryDateController.dispose();
    heightController.dispose();
    weightController.dispose();
    heartrateController.dispose();
    bloodPressureController.dispose();
    performanceController.dispose();
    oxygenController.dispose();
    diseaseController.dispose();
    medicationController.dispose();
    photoController.dispose();
    super.dispose();
  }

  List<int> validValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  addPatient() async {
    if (performanceController.text.contains(",")) {
      performanceController.text = performanceController.text.replaceAll(",", ".");
    }
    bool exists = await userApi.existsEmail(emailController.text, existingUserId: widget.userId) ?? false;
    setState(() {
      duplicateMail = exists;
    });
    if (isKlimafit() && homeLocation == null) {
      setState(() {
        homeLocationErrorLabel = context.i18n.validationNotEmpty;
      });
      return;
    }
    if (_addPatientFormKey.currentState!.validate()) {
      final userRepository = KiwiContainer().resolve<UserRepository>();
      PatientGetDTO patient = PatientGetDTO(
        activityClass: activityValue,
        birthDate: birthdayController.text.isNotEmpty ? englishDateFormat.format(germanDateFormat.parse(birthdayController.text)) : null,
        surgeryDate: surgeryDateController.text.isNotEmpty ? englishDateFormat.format(germanDateFormat.parse(surgeryDateController.text)) : null,
        surgeryTime: surgeryTime,
        diseases: diseaseController.text,
        email: emailController.text,
        participantId: participantIdController.text,
        firstName: firstNameController.text,
        healthcareProfessionalId: widget.healthcareProfessionalId ?? userRepository.currentUser.id,
        height: int.tryParse(heightController.text) ?? 0,
        lastName: lastNameController.text,
        maximumBloodPressure: bloodPressureController.text,
        maximumHeartRate: int.tryParse(heartrateController.text) ?? 0,
        maximumOxygenConsumption: double.tryParse(oxygenController.text) ?? 0,
        maximumPerformance: double.tryParse(performanceController.text) ?? 0,
        medication: medicationController.text,
        weight: int.tryParse(weightController.text) ?? 0,
        homeLocation: homeLocation,
        homeLocationAddress: homeLocationAddress,
        workLocation: workLocation,
        workLocationAddress: workLocationAddress,
        heatTolerance: heatTolerance,
        mobilityPreferences: mobilityPreferencesController.selectedItems.map((entry) => entry.value).toList(),
        dislikedMobilityPreferences: dislikedMobilityPreferencesController.selectedItems.map((entry) => entry.value).toList(),
        preferredActivities: preferredActivityTypesController.selectedItems.map((entry) => entry.value).toList(),
        dislikedActivities: dislikedActivityTypesController.selectedItems.map((entry) => entry.value).toList(),
      );

      userBloc!.add(AddUserEvent(newUser: patient, picture: profilePicture));
      goBack();
    }
  }

  updatePatient() async {
    if (performanceController.text.contains(",")) {
      performanceController.text = performanceController.text.replaceAll(",", ".");
    }
    bool exists = await userApi.existsEmail(emailController.text, existingUserId: widget.userId) ?? false;
    setState(() {
      duplicateMail = exists;
    });
    if (isKlimafit() && homeLocation == null) {
      setState(() {
        homeLocationErrorLabel = context.i18n.validationNotEmpty;
      });
      return;
    }
    if (_addPatientFormKey.currentState!.validate()) {
      this.patient = PatientGetDTO(
        activityClass: activityValue,
        birthDate: birthdayController.text.isNotEmpty ? englishDateFormat.format(germanDateFormat.parse(birthdayController.text)) : null,
        surgeryDate: surgeryDateController.text.isNotEmpty ? englishDateFormat.format(germanDateFormat.parse(surgeryDateController.text)) : null,
        surgeryTime: surgeryTime,
        diseases: diseaseController.text,
        email: emailController.text,
        participantId: participantIdController.text,
        firstName: firstNameController.text,
        healthcareProfessionalId: widget.healthcareProfessionalId ?? this.patient!.healthcareProfessionalId,
        height: int.tryParse(heightController.text) ?? 0,
        id: this.patient!.id,
        lastName: lastNameController.text,
        maximumBloodPressure: bloodPressureController.text,
        maximumHeartRate: int.tryParse(heartrateController.text) ?? 0,
        maximumOxygenConsumption: double.tryParse(oxygenController.text) ?? 0,
        maximumPerformance: double.tryParse(performanceController.text) ?? 0,
        medication: medicationController.text,
        weight: int.tryParse(weightController.text) ?? 0,
        homeLocation: homeLocation,
        homeLocationAddress: homeLocationAddress,
        workLocation: workLocation,
        workLocationAddress: workLocationAddress,
        heatTolerance: heatTolerance,
        mobilityPreferences: mobilityPreferencesController.selectedItems.map((entry) => entry.value).toList(),
        dislikedMobilityPreferences: dislikedMobilityPreferencesController.selectedItems.map((entry) => entry.value).toList(),
        preferredActivities: preferredActivityTypesController.selectedItems.map((entry) => entry.value).toList(),
        dislikedActivities: dislikedActivityTypesController.selectedItems.map((entry) => entry.value).toList(),
      );

      userBloc!.add(UpdateUserEvent(id: patient!.id!, user: patient, picture: profilePicture));
      final userRepository = KiwiContainer().resolve<UserRepository>();
      var userRole = userRepository.userRole;
      if (widget.healthcareProfessionalId != null && userRole != UserRole.ADMINISTRATOR) {
        userBloc!.add(FetchSinglePatientEvent(id: patient!.id));
      }
      goBack();
    }
  }

  goBack() {
    if (context.canBeamBack && (widget.edit || userRepository.userRole == UserRole.ADMINISTRATOR)) {
      context.beamBack();
    } else {
      if (this.patient != null && widget.edit) {
        context.beamToNamed("patients/${this.patient!.id}/calendar", data: {"patient": this.patient}, beamBackOnPop: true);
      } else if (userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
        context.beamToNamed("/patients");
      } else {
        context.beamToNamed("/professionals/${widget.healthcareProfessionalId}/patients", beamBackOnPop: true);
      }
    }
  }

  deletePatient() {
    userBloc!.add(DeletePatientEvent(id: widget.patient!.id!, healthcareProfessionalId: widget.patient!.healthcareProfessionalId!));
    context.beamToNamed("/professionals/${widget.healthcareProfessionalId}/patients");
  }

  void _openFileExplorer() async {
    try {
      final List<PlatformFile> _paths = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
          ))
              ?.files ??
          [];
      if (_paths.isEmpty) {
        return;
      }
      final PlatformFile _file = _paths.first;
      profilePicture = _file.bytes != null
          ? MultipartFile.fromBytes(
              "pictureFile",
              _file.bytes!,
              filename: _file.name,
            )
          : await MultipartFile.fromPath("pictureFile", _file.path!, filename: _file.name);
      if (profilePicture!.length > ImageFormField.MAX_FILESIZE) {
        ImageFormField.showFileTooBigDialog(context);
        return;
      }
      setState(() {
        photoController.text = _file.name;
        uploadedPicturePath = _file.path ?? "";
      });
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {});
  }

  void _showConsentInfoDialog(width) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText(
                        text: context.i18n.consentTextCreatePatientDetail,
                        tags: {
                          'b': StyledTextTag(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => errorColor,
                    ),
                  ),
                  child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.close.toUpperCase())),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ));
  }

  getImage() async {
    _openFileExplorer();
  }

  void getPatient() async {
    final UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();

    if (widget.edit) {
      if (widget.patient != null) {
        patient = widget.patient;
      } else if (userRepository.userRole == UserRole.PATIENT) {
        patient = userRepository.user!.patient!;
      } else {
        patient = (await userControllerRepository.getPatientbyId(id: widget.userId!))!.user;
      }
      participantIdController.text = patient!.participantId ?? "";
      firstNameController.text = patient!.firstName ?? "";
      lastNameController.text = patient!.lastName ?? "";
      emailController.text = patient!.email ?? "";
      birthdayController.text = patient!.birthDate?.isNotEmpty ?? false ? germanDateFormat.format(DateTime.parse(patient!.birthDate!)) : "";
      surgeryDateController.text = patient!.surgeryDate?.isNotEmpty ?? false ? germanDateFormat.format(DateTime.parse(patient!.surgeryDate!)) : "";
      activityValue = patient!.activityClass;
      heightController.text = patient!.height?.toString() ?? "";
      weightController.text = patient!.weight?.toString() ?? "";
      heartrateController.text = (patient!.maximumHeartRate ?? 0) > 0 ? patient!.maximumHeartRate!.toString() : "";
      bloodPressureController.text = patient!.maximumBloodPressure.toString();
      performanceController.text = (patient!.maximumPerformance ?? 0) > 0 ? patient!.maximumPerformance.toString() : "";
      oxygenController.text = (patient!.maximumOxygenConsumption ?? 0) > 0 ? patient!.maximumOxygenConsumption.toString() : "";
      diseaseController.text = patient!.diseases ?? "-";
      medicationController.text = patient!.medication ?? "-";
      final pictureValue = await userControllerRepository.getUserPicture(id: patient!.id!, userRole: UserRole.PATIENT);
      setState(() {
        surgeryTime = patient!.surgeryTime ?? "";
        userPicture = pictureValue;
        homeLocation = patient!.homeLocation;
        homeLocationAddress = patient!.homeLocationAddress ?? "";
        workLocation = patient!.workLocation;
        workLocationAddress = patient!.workLocationAddress ?? "";
        heatTolerance = patient!.heatTolerance ?? HeatTolerance.AVERAGE;
        mobilityPreferencesItems.forEach((item) => item.selected = patient!.mobilityPreferences.contains(item.value));
        dislikedMobilityPreferencesItems.forEach((item) => item.selected = patient!.dislikedMobilityPreferences.contains(item.value));
        preferredActivityTypesItems.forEach((item) => item.selected = patient!.preferredActivities.contains(item.value));
        dislikedActivityTypesItems.forEach((item) => item.selected = patient!.dislikedActivities.contains(item.value));
      });
    }
  }

  bool isKlimafit() {
    return institution?.institutionFocus?.isKlimafit() ?? false;
  }

  void _syncDislikedMobilityProperties() {
    if (syncingMobilityProperties) {
      return;
    }
    syncingMobilityProperties = true;
    final selectedPreferredValues = mobilityPreferencesController.selectedItems.map((e) => e.value).toSet();

    setState(() {
      dislikedMobilityPreferencesController.unselectWhere((item) => selectedPreferredValues.contains(item.value));
    });
    syncingMobilityProperties = false;
  }

  void _syncDislikedActivityProperties() {
    if (syncingPredefinedActivityProperties) {
      return;
    }
    syncingPredefinedActivityProperties = true;
    final selectedPreferredValues = preferredActivityTypesController.selectedItems.map((e) => e.value).toSet();

    setState(() {
      dislikedActivityTypesController.unselectWhere((item) => selectedPreferredValues.contains(item.value));
    });
    syncingPredefinedActivityProperties = false;
  }

  void _syncPreferredMobilityProperties() {
    if (syncingMobilityProperties) {
      return;
    }
    syncingMobilityProperties = true;
    final selectedDislikedValues = dislikedMobilityPreferencesController.selectedItems.map((e) => e.value).toSet();

    setState(() {
      mobilityPreferencesController.unselectWhere((item) => selectedDislikedValues.contains(item.value));
    });
    syncingMobilityProperties = false;
  }

  void _syncPreferredActivityProperties() {
    if (syncingPredefinedActivityProperties) {
      return;
    }
    syncingPredefinedActivityProperties = true;
    final selectedDislikedValues = dislikedActivityTypesController.selectedItems.map((e) => e.value).toSet();

    setState(() {
      preferredActivityTypesController.unselectWhere((item) => selectedDislikedValues.contains(item.value));
    });
    syncingPredefinedActivityProperties = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final userRepository = KiwiContainer().resolve<UserRepository>();
    var userRole = userRepository.userRole;
    bool isPrehabToRehab = institution?.institutionFocus == InstitutionFocus.PREHAB_TO_REHAB;

    return AptLayout(
      border: false,
      fixedHeight: false,
      breadCrumb: <BreadCrumbItem>[
        BreadCrumbItem(
          content: Padding(
            padding: EdgeInsets.only(left: 10),
            child: SelectableText(
              context.i18n.patient,
              style: getBreadCrumbStyle(context),
            ),
          ),
        ),
      ],
      children: [
        Form(
          key: _addPatientFormKey,
          child: ((widget.edit && patient == null) || institution == null)
              ? Center(child: CircularProgressIndicator())
              : BlocProvider(
                  lazy: false,
                  create: (context) => MailBloc(),
                  child: SingleChildScrollView(
                    key: Key(KEY_PATIENT_DATA_SCROLL_VIEW),
                    child: ResponsiveBuilder(
                      builder: (context, size) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isPrehabToRehab) ...[
                              FormFieldPadding(
                                child: TextFormField(
                                  controller: participantIdController,
                                  readOnly: userRole == UserRole.PATIENT,
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return context.i18n.validationNotEmpty;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    hintText: context.i18n.participantId,
                                    labelText: context.i18n.participantId + ' *',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              FormFieldPadding(
                                child: TextFormField(
                                  controller: surgeryDateController,
                                  readOnly: userRole == UserRole.PATIENT,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return null;
                                    } else if (value!.length != 10) {
                                      return context.i18n.validationInvalidValue;
                                    } else {
                                      final day = int.parse(value.substring(0, 2));
                                      final month = int.parse(value.substring(3, 5));
                                      final year = int.parse(value.substring(6));
                                      if (day < 0 || day > 31 || month < 1 || month > 12 || year < 1900) {
                                        return context.i18n.validationInvalidValue;
                                      }
                                      return null;
                                    }
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    hintText: "01.01.1950",
                                    labelText: context.i18n.surgeryDate,
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: () async {
                                        final date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(DateTime.now().year + 5));
                                        if (date != null) {
                                          setState(() {
                                            surgeryDateController.text = germanDateFormat.format(date);
                                            this.hasChanges = true;
                                          });
                                        }
                                      },
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              FormFieldPadding(
                                child: TimePickerRow(
                                  initialTime: surgeryTime,
                                  labelText: context.i18n.surgeryTime,
                                  useDefaultBorder: true,
                                  selectTime: (selectedTime) {
                                    setState(() {
                                      surgeryTime = selectedTime;
                                      hasChanges = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                            FormFieldPadding(
                              child: TextFormField(
                                controller: firstNameController,
                                readOnly: userRole == UserRole.PATIENT,
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  } else if (value!.length < 2 || value.length > 100) {
                                    return context.i18n.validationDefaultLength;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.firstName,
                                  labelText: context.i18n.firstName + ' *',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: lastNameController,
                                readOnly: userRole == UserRole.PATIENT,
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return context.i18n.validationNotEmpty;
                                  } else if (value!.length < 2 || value.length > 100) {
                                    return context.i18n.validationDefaultLength;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.lastName,
                                  labelText: context.i18n.lastName + ' *',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: emailController,
                                readOnly: userRole == UserRole.PATIENT,
                                validator: (value) {
                                  if ((value ?? "").isEmpty || !EmailValidator.validate((value ?? "").trim())) {
                                    return context.i18n.validationEmail;
                                  } else if (duplicateMail) {
                                    return context.i18n.validationDuplicateEmail;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.email,
                                  labelText: context.i18n.email + ' *',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: birthdayController,
                                readOnly: userRole == UserRole.PATIENT,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    if (isPrehabToRehab) {
                                      return null;
                                    }
                                    return context.i18n.validationNotEmpty;
                                  } else if (value!.length != 10 || germanDateFormat.parse(value).isAfter(DateTime.now())) {
                                    return context.i18n.validationInvalidValue;
                                  } else {
                                    final day = int.parse(value.substring(0, 2));
                                    final month = int.parse(value.substring(3, 5));
                                    final year = int.parse(value.substring(6));
                                    if (day < 0 || day > 31 || month < 1 || month > 12 || year < 1900) {
                                      return context.i18n.validationInvalidValue;
                                    }
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: "01.01.1950",
                                  labelText: context.i18n.birthdate + (isPrehabToRehab ? '' : ' *'),
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                          context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
                                      if (date != null) {
                                        setState(() {
                                          birthdayController.text = germanDateFormat.format(date);
                                          this.hasChanges = true;
                                        });
                                      }
                                    },
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: heightController,
                                readOnly: userRole == UserRole.PATIENT,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    if (isPrehabToRehab) {
                                      return null;
                                    }
                                    return context.i18n.validationNotEmpty;
                                  } else if (int.parse(value!) < MIN_HEIGHT || int.parse(value) > MAX_HEIGHT) {
                                    return context.i18n.validationInvalidValue;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.bodyHeightWithUnit,
                                  labelText: context.i18n.bodyHeightWithUnit + (isPrehabToRehab ? '' : ' *'),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: weightController,
                                readOnly: userRole == UserRole.PATIENT,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    if (isPrehabToRehab) {
                                      return null;
                                    }
                                    return context.i18n.validationNotEmpty;
                                  } else if (int.parse(value!) < MIN_WEIGHT || int.parse(value) > MAX_WEIGHT) {
                                    return context.i18n.validationInvalidValue;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.bodyWeightWithUnit,
                                  labelText: context.i18n.bodyWeightWithUnit + (isPrehabToRehab ? '' : ' *'),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            //aktivitätsklasse
                            FormFieldPadding(
                              child: userRole == UserRole.PATIENT
                                  ? TextFormField(
                                      initialValue: getRatingText(context, activityValue),
                                      readOnly: true,
                                      onChanged: (value) => {
                                            setState(() {
                                              this.hasChanges = true;
                                            })
                                          },
                                      decoration: InputDecoration(
                                        hintText: context.i18n.activityClass,
                                        labelText: context.i18n.activityClass,
                                        border: OutlineInputBorder(),
                                      ))
                                  : DropdownButtonFormField(
                                      initialValue: activityValue,
                                      onChanged: (value) {
                                        setState(() {
                                          activityValue = int.tryParse(value.toString());
                                          this.hasChanges = true;
                                        });
                                      },
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        labelText: context.i18n.activityClass + (isPrehabToRehab ? '' : ' *'),
                                        border: const OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (isPrehabToRehab) {
                                          return null;
                                        }
                                        return value == null || value == -1 ? context.i18n.validationNotEmpty : null;
                                      },
                                      items: validValues.map((num) {
                                        return DropdownMenuItem<int>(
                                          child: FittedBox(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                if (!size.isMobile)
                                                  InkWell(
                                                      child: Icon(Icons.info_outline, size: 18),
                                                      onTap: () => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => ActivityClassesPage(),
                                                            ),
                                                          )),
                                                if (!size.isMobile)
                                                  SizedBox(
                                                    width: width * 0.003,
                                                  ),
                                                Text("$num - ${getRatingText(context, num)}")
                                              ],
                                            ),
                                          ),
                                          value: num,
                                        );
                                      }).toList(),
                                    ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: heartrateController,
                                readOnly: userRole == UserRole.PATIENT,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return null;
                                  } else if (int.parse(value!) < MIN_HEARTRATE || int.parse(value) > MAX_HEARTRATE) {
                                    return context.i18n.validationInvalidValue;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.maximumHeartRateWithUnit,
                                  labelText: context.i18n.maximumHeartRateWithUnit,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            if (institution?.institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION ||
                                institution?.institutionFocus == InstitutionFocus.PREHAB_TO_REHAB)
                              FormFieldPadding(
                                child: TextFormField(
                                  controller: bloodPressureController,
                                  readOnly: userRole == UserRole.PATIENT,
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return null;
                                    } else if ((value ?? "").isNotEmpty) {
                                      List bloodPressure = value!.trim().split("/");
                                      int systolic = int.tryParse(bloodPressure.first) ?? 0;
                                      int diastolic = int.tryParse(bloodPressure.last) ?? 0;
                                      if (systolic < MIN_SYSTOLIC ||
                                          systolic > MAX_SYSTOLIC ||
                                          diastolic < MIN_DIASTOLIC ||
                                          diastolic > MAX_DIASTOLIC) {
                                        return context.i18n.validationInvalidValue;
                                      }
                                    } else if (!(value ?? "").contains('/')) {
                                      return context.i18n.validationInvalidValue;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    hintText: context.i18n.maximumBloodPressureWithUnit,
                                    labelText: context.i18n.maximumBloodPressureWithUnit,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            if (institution?.institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION ||
                                institution?.institutionFocus == InstitutionFocus.PREHAB_TO_REHAB)
                              FormFieldPadding(
                                child: TextFormField(
                                  controller: performanceController,
                                  readOnly: userRole == UserRole.PATIENT,
                                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter(RegExp(r"^\d+[.,]?\d{0,2}"), allow: true)],
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return null;
                                    } else if (double.parse(value!) < MIN_PERFORMANCE || double.parse(value) > MAX_PERFORMANCE) {
                                      return context.i18n.validationInvalidValue;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    hintText: context.i18n.maximumPerformanceWithUnit,
                                    labelText: context.i18n.maximumPerformanceWithUnit,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            if (institution?.institutionFocus == InstitutionFocus.CARDIOVASCULAR_REHABILITATION ||
                                institution?.institutionFocus == InstitutionFocus.PREHAB_TO_REHAB)
                              FormFieldPadding(
                                child: TextFormField(
                                  controller: oxygenController,
                                  readOnly: userRole == UserRole.PATIENT,
                                  keyboardType: TextInputType.numberWithOptions(signed: true),
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return null;
                                    } else if (int.parse(value!) < MIN_OXYGEN || int.parse(value) > MAX_OXYGEN) {
                                      return context.i18n.validationInvalidValue;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => {
                                    setState(() {
                                      this.hasChanges = true;
                                    })
                                  },
                                  decoration: InputDecoration(
                                    hintText: context.i18n.maximumOxygenWithUnit,
                                    labelText: context.i18n.maximumOxygenWithUnit,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: diseaseController,
                                readOnly: userRole == UserRole.PATIENT,
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.comorbidities,
                                  labelText: context.i18n.comorbidities,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            FormFieldPadding(
                              child: TextFormField(
                                controller: medicationController,
                                readOnly: userRole == UserRole.PATIENT,
                                onChanged: (value) => {
                                  setState(() {
                                    this.hasChanges = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  hintText: context.i18n.medication,
                                  labelText: context.i18n.medication,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            if (isKlimafit())
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  LocationPicker(
                                    labelText: context.i18n.homeLocation + ' *',
                                    onLocationChanged: (location, address) {
                                      setState(() {
                                        homeLocation = location;
                                        homeLocationAddress = address;
                                        if (location != null) {
                                          homeLocationErrorLabel = "";
                                        }
                                        hasChanges = true;
                                      });
                                    },
                                    initialLocation: homeLocation,
                                    initialLocationAddress: homeLocationAddress,
                                    errorText: homeLocationErrorLabel,
                                  ),
                                  const SizedBox(height: 16),
                                  LocationPicker(
                                      labelText: context.i18n.workLocation,
                                      onLocationChanged: (location, address) {
                                        setState(() {
                                          workLocation = location;
                                          workLocationAddress = address;
                                          hasChanges = true;
                                        });
                                      },
                                      initialLocation: workLocation,
                                      initialLocationAddress: workLocationAddress),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField(
                                    initialValue: heatTolerance,
                                    onChanged: (value) {
                                      setState(() {
                                        heatTolerance = value!;
                                        this.hasChanges = true;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: context.i18n.heatTolerance,
                                      labelText: context.i18n.heatTolerance,
                                      border: OutlineInputBorder(),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(context.i18n.heatTolerance_POOR),
                                        value: HeatTolerance.POOR,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(context.i18n.heatTolerance_AVERAGE),
                                        value: HeatTolerance.AVERAGE,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(context.i18n.heatTolerance_GOOD),
                                        value: HeatTolerance.GOOD,
                                      ),
                                    ],
                                  ),
                                  FormFieldPadding(
                                    child: MultiDropdown<MobilityPreference>(
                                      controller: mobilityPreferencesController,
                                      items: mobilityPreferencesItems,
                                      fieldDecoration: FieldDecoration(
                                        hintText: context.i18n.mobilityPreference,
                                        labelText: context.i18n.mobilityPreference,
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                      ),
                                      dropdownDecoration: DropdownDecoration(borderRadius: BorderRadius.zero),
                                      onSelectionChange: (_) => _syncDislikedMobilityProperties(),
                                    ),
                                  ),
                                  FormFieldPadding(
                                    child: MultiDropdown<MobilityPreference>(
                                      controller: dislikedMobilityPreferencesController,
                                      items: dislikedMobilityPreferencesItems,
                                      fieldDecoration: FieldDecoration(
                                        hintText: context.i18n.dislikedMobilityPreference,
                                        labelText: context.i18n.dislikedMobilityPreference,
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                      ),
                                      dropdownDecoration: DropdownDecoration(borderRadius: BorderRadius.zero),
                                      onSelectionChange: (_) => _syncPreferredMobilityProperties(),
                                    ),
                                  ),
                                  FormFieldPadding(
                                    child: MultiDropdown<PredefinedActivityType>(
                                      controller: preferredActivityTypesController,
                                      items: preferredActivityTypesItems,
                                      fieldDecoration: FieldDecoration(
                                        hintText: context.i18n.activityPreference,
                                        labelText: context.i18n.activityPreference,
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                      ),
                                      dropdownDecoration: DropdownDecoration(borderRadius: BorderRadius.zero),
                                      onSelectionChange: (_) => _syncDislikedActivityProperties(),
                                    ),
                                  ),
                                  FormFieldPadding(
                                    child: MultiDropdown<PredefinedActivityType>(
                                      controller: dislikedActivityTypesController,
                                      items: dislikedActivityTypesItems,
                                      fieldDecoration: FieldDecoration(
                                        hintText: context.i18n.dislikedActivityPreference,
                                        labelText: context.i18n.dislikedActivityPreference,
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                      ),
                                      dropdownDecoration: DropdownDecoration(borderRadius: BorderRadius.zero),
                                      onSelectionChange: (_) => _syncPreferredActivityProperties(),
                                    ),
                                  ),
                                ],
                              ),
                            ImageFormField(controller: photoController, callback: getImage),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SelectableText(context.i18n.hintRequiredFields,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: lightTextColor,
                                          ))
                                ],
                              ),
                            ),
                            (userPicture?.exists ?? false) || uploadedPicturePath.isNotEmpty
                                ? FormFieldPadding(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ClipOval(
                                        child: uploadedPicturePath.isNotEmpty
                                            ? kIsWeb
                                                ? Image.network(
                                                    uploadedPicturePath,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    File(uploadedPicturePath),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  )
                                            : Image.network(
                                                userPicture!.url!,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            if (!widget.edit)
                              FormFieldPadding(
                                child: FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: [
                                        ListTileTheme(
                                          contentPadding: EdgeInsets.zero,
                                          child: CheckboxListTile(
                                            controlAffinity: ListTileControlAffinity.leading,
                                            activeColor: Colors.black,
                                            value: acceptedTerms,
                                            onChanged: (value) {
                                              setState(() {
                                                acceptedTerms = value ?? false;
                                                state.didChange(value);
                                              });
                                            },
                                            title: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(context.i18n.consentTextCreatePatient),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                  ),
                                                  onPressed: () => _showConsentInfoDialog(width),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text(
                                              state.errorText ?? '',
                                              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  validator: (value) {
                                    if (!acceptedTerms) {
                                      return context.i18n.pleaseAcceptTerms;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            FormFieldPadding(
                              child: Wrap(
                                children: [
                                  if (widget.edit)
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, right: 10),
                                      child: SaveButton(
                                        title: context.i18n.save.toUpperCase(),
                                        callback: updatePatient,
                                      ),
                                    ),
                                  if (patient != null && (patient!.lastActiveDate ?? "").isEmpty)
                                    BlocBuilder<MailBloc, MailState>(
                                      builder: (context, state) {
                                        if (state is MailInitial) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 10, right: 10),
                                            child: Wrap(
                                              children: [
                                                ElevatedButton(
                                                  child: Text(
                                                    context.i18n.sendInvitationMailAgain.toUpperCase(),
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  onPressed: () =>
                                                      BlocProvider.of<MailBloc>(context).add(SendWelcomeEmailEvent(patientId: patient!.id!)),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (state is MailWaiting) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 10, right: 10),
                                            child: Wrap(
                                              children: [
                                                Container(
                                                  child: CircularProgressIndicator(
                                                    backgroundColor: Theme.of(context).primaryColor,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8, top: 8),
                                                  child: Text(context.i18n.emailBeingSent),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (state is MailSent) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 10, right: 10),
                                            child: Wrap(
                                              children: [
                                                Icon(
                                                  Icons.done,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8, top: 4),
                                                  child: Text(context.i18n.emailSent),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (state is MailError) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 10, right: 10),
                                            child: Wrap(
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(context.i18n.emailSentError),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(context.i18n.tryAgainLater),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  if (!widget.edit)
                                    Padding(
                                      padding: EdgeInsets.only(top: 10, right: 10),
                                      child: SaveButton(
                                        title: context.i18n.register.toUpperCase(),
                                        callback: addPatient,
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: CancelButton(
                                      callback: () => goBack(),
                                      hasChanges: this.hasChanges,
                                    ),
                                  ),
                                  if (widget.edit && userRole != UserRole.PATIENT)
                                    Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: DeleteButton(
                                        callback: deletePatient,
                                        confirmationTitle: context.i18n.deleteMessagePatientsTitle,
                                        confirmationText: context.i18n.deleteMessagePatients("${patient!.firstName} ${patient!.lastName}"),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  String get traceablePageName => "Modify Patient Page";
}
