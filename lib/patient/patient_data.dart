import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/patient/bloc/mailbloc.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/user/user_controller_repository.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/trace_helpers.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:aptapp/widget/image_form_field.dart';
import 'package:aptapp/widget/password_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PatientDataPage extends StatefulWidget {
  final PatientGetDTO patient;

  PatientDataPage({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  _PatientDataPageState createState() => _PatientDataPageState();
}

class _PatientDataPageState extends State<PatientDataPage> with TraceablePageMixin {
  UserBloc? userBloc;
  PatientGetDTO? newPatient;
  FileGetDTO? userPicture;
  final userApi = new UserControllerApi(apiClient);
  final _changeFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();
  PatientState? patientState;
  bool isValidPassword = true;
  bool shareActivityData = false;
  bool shareActiveMinutes = true;
  bool loadedData = false;
  String uploadedPicturePath = "";
  bool doEditStatusMessage = false;
  final statusMessageController = TextEditingController();

  final institutionApi = new InstitutionControllerApi(apiClient);
  InstitutionDTO? institution;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    loadedData = false;
    statusMessageController.text = widget.patient.statusMessage ?? "";
    KiwiContainer().resolve<UserControllerRepository>().getUserPicture(id: widget.patient.id!, userRole: UserRole.PATIENT).then((value) {
      setState(() {
        userPicture = value!;
      });
    });
    if ((widget.patient.institutionId ?? "").isNotEmpty) {
      institutionApi.getInstitutionById(widget.patient.institutionId!).then((value) {
        setState(() {
          institution = value;
        });
      });
    }
  }

  uploadImage() async {
    var oldPicture = userPicture;
    try {
      final List<PlatformFile> files = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
          ))
              ?.files ??
          [];
      if (files.isEmpty) {
        return;
      }
      final PlatformFile _file = files.first;
      var file = _file.bytes != null
          ? MultipartFile.fromBytes(
              "pictureFile",
              _file.bytes!,
              filename: _file.name,
            )
          : await MultipartFile.fromPath("pictureFile", _file.path!, filename: _file.name);
      if (file.length > ImageFormField.MAX_FILESIZE) {
        ImageFormField.showFileTooBigDialog(context);
        return;
      }
      setState(() {
        uploadedPicturePath = _file.path ?? "";
      });
      var value = await userApi.uploadUserPictureById(widget.patient.id!, UserRole.PATIENT, file);
      setState(() {
        userPicture = value;
      });
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
      setState(() {
        userPicture = oldPicture;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        userPicture = oldPicture;
      });
    }
  }

  showAlertDialog(BuildContext context, String text, String confirmText, String cancelText, Function callback) {
    AlertDialog alert = AlertDialog(
      content: Text(text),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => primaryColor,
                ),
              ),
              child: FittedBox(fit: BoxFit.contain, child: Text(confirmText)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                callback();
              }),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => errorColor,
              ),
            ),
            child: FittedBox(fit: BoxFit.contain, child: Text(cancelText)),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteImage() {
    userApi.deleteUserPictureById(widget.patient.id!, UserRole.PATIENT);
    setState(() {
      uploadedPicturePath = "";
      userPicture!.exists = false;
    });
  }

  showChangeDataDialog() {
    double width = MediaQuery.of(context).size.width;
    final descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              key: Key(KEY_BUTTON_CLOSE),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            heightFactor: 1.0,
            child: ResponsiveBuilder(
              builder: (context, size) {
                final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
                return SingleChildScrollView(
                  key: Key(KEY_PATIENT_PROFILE_SCROLL_VIEW),
                  child: Container(
                    width: containerWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        SelectableText(
                          context.i18n.changeOfMyHealthData,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _changeFormKey,
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: context.i18n.description,
                              hintMaxLines: 1,
                              labelText: context.i18n.description + " *",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: datatableBorderColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return context.i18n.validationNotEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: getElevatedButtonStyle(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.i18n.requestChange.toUpperCase()),
                            ],
                          ),
                          onPressed: () => sendChangeRequest(descriptionController, size.isMobile),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.i18n.cancel.toUpperCase()),
                            ],
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  showChangePasswordDialog() {
    double width = MediaQuery.of(context).size.width;
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final newPasswordConfirmationController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              key: Key(KEY_BUTTON_CLOSE),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            heightFactor: 1.0,
            child: ResponsiveBuilder(
              builder: (context, size) {
                final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
                return SingleChildScrollView(
                  key: Key(KEY_PATIENT_PROFILE_SCROLL_VIEW),
                  child: Container(
                    width: containerWidth,
                    child: Form(
                      key: _changePasswordFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          SelectableText(
                            context.i18n.changePassword,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          PasswordFormField(
                            controller: oldPasswordController,
                            labelText: context.i18n.oldPassword,
                            additionalValidations: (value) {
                              if (!isValidPassword) {
                                return context.i18n.validationWrongPassword;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          PasswordFormField(
                            controller: newPasswordController,
                            labelText: context.i18n.newPassword,
                            additionalValidations: (value) {
                              if (value != newPasswordConfirmationController.text) {
                                return context.i18n.validationPasswordsNotEqual;
                              }
                              return null;
                            },
                            onSubmitted: (value) {
                              if (newPasswordConfirmationController.text.isEmpty) {
                                return;
                              }
                              sendPasswordChangeRequest(oldPasswordController.text, value, size.isMobile);
                            },
                          ),
                          SizedBox(height: 20),
                          PasswordFormField(
                            controller: newPasswordConfirmationController,
                            labelText: context.i18n.confirmNewPassword,
                            additionalValidations: (value) {
                              if (value != newPasswordController.text) {
                                return context.i18n.validationPasswordsNotEqual;
                              }
                              return null;
                            },
                            onSubmitted: (value) {
                              if (newPasswordController.text.isEmpty) {
                                return;
                              }
                              sendPasswordChangeRequest(oldPasswordController.text, value, size.isMobile);
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              style: getElevatedButtonStyle(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.i18n.save.toUpperCase()),
                                ],
                              ),
                              onPressed: () => sendPasswordChangeRequest(oldPasswordController.text, newPasswordController.text, size.isMobile)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(context.i18n.cancel.toUpperCase()),
                              ],
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  sendPasswordChangeRequest(String oldPassword, String newPassword, final bool isMobile) async {
    isValidPassword = true;
    if (!_changePasswordFormKey.currentState!.validate()) {
      return;
    }
    isValidPassword = await userRepository.changePassword(ChangePasswordDTO(
      oldPassword: oldPassword,
      newPassword: newPassword,
    ));
    if (!isValidPassword) {
      _changePasswordFormKey.currentState!.validate();
      return;
    }
    Navigator.of(context).pop();
    getSnackbar(context.i18n.updatedPassword, isMobile, context).show(context);
  }

  sendChangeRequest(final TextEditingController descriptionController, final bool isMobile) {
    if (!_changeFormKey.currentState!.validate()) {
      return;
    }
    userApi.requestHealthDataChange(HealthDataChangeDTO(description: descriptionController.text));
    Navigator.of(context).pop();
    getSnackbar(context.i18n.requestedChange, isMobile, context).show(context);
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_PROFILE, name: EVENT_NAME_UPDATE, action: "Requested Profile Update"),
    );
  }

  deleteProfile(final bool isMobile) {
    userApi.requestProfileDeletion();
    getSnackbar(
            context.i18n.requestedProfileDeletion((userRepository.currentHealthcareProfessional?.firstName ?? "") +
                " " +
                (userRepository.currentHealthcareProfessional?.lastName ?? "")),
            isMobile,
            context)
        .show(context);
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: EVENT_CATEGORY_PATIENT_PROFILE, name: EVENT_NAME_DELETE, action: "Requested Profile Deletion"),
    );
  }

  showProfilePictureActionButtons() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: getElevatedButtonStyle(context),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.i18n.uploadProfilePicture),
                  ],
                ),
                onPressed: () {
                  uploadImage();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.i18n.deleteProfilePicture),
                  ],
                ),
                onPressed: () =>
                    showAlertDialog(context, context.i18n.deleteProfilePictureText, context.i18n.deleteProfilePicture, context.i18n.deleteNo, () {
                  deleteImage();
                  Navigator.of(context).pop();
                }),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.i18n.cancel),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      lazy: false,
      create: (context) => MailBloc(),
      child: SingleChildScrollView(
        key: Key(KEY_PATIENT_DATA_SCROLL_VIEW),
        child: Center(
          child: ResponsiveBuilder(builder: (context, size) {
            if (userPicture == null) {
              return Padding(padding: EdgeInsets.only(top: 40), child: CircularProgressIndicator());
            }
            final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
            return Container(
              width: containerWidth,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is FetchedSinglePatientState) {
                    newPatient = state.patient.user;
                  }
                  PatientGetDTO patient = newPatient ?? widget.patient;
                  if (!loadedData) {
                    patientState = patient.patientState;
                    shareActivityData = patient.shareActivityData ?? false;
                    shareActiveMinutes = patient.shareActiveMinutes ?? true;
                    loadedData = true;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          (userPicture?.exists ?? false || uploadedPicturePath.isNotEmpty)
                              ? ClipOval(
                                  child: uploadedPicturePath.isNotEmpty
                                      ? kIsWeb
                                          ? Image.network(
                                              uploadedPicturePath,
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(uploadedPicturePath),
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.cover,
                                            )
                                      : Image.network(
                                          userPicture!.url!,
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.cover,
                                        ),
                                )
                              : Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                  size: 56,
                                ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  "${patient.firstName} ${patient.lastName}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                SelectableText(patient.email ?? "")
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: getElevatedButtonStyle(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text((userPicture?.exists ?? false)
                                ? context.i18n.editProfilePicture.toUpperCase()
                                : context.i18n.addProfilePicture.toUpperCase()),
                          ],
                        ),
                        onPressed: () => userPicture?.exists ?? false ? showProfilePictureActionButtons() : uploadImage(),
                      ),
                      SizedBox(height: 10),
                      if (institution?.enableSocialFeatures ?? false) ...[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: SelectableText(context.i18n.statusMessage,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: lightTextColor,
                                      )),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(children: [
                                Expanded(
                                  child: !doEditStatusMessage
                                      ? Text(statusMessageController.text)
                                      : TextFormField(
                                          controller: statusMessageController,
                                          maxLength: 40,
                                        ),
                                ),
                                IconButton(
                                  icon: Icon(doEditStatusMessage ? Icons.save : Icons.edit),
                                  onPressed: () {
                                    if (doEditStatusMessage) {
                                      userRepository.updateStatusMessage(statusMessageController.text);
                                    }
                                    setState(() {
                                      doEditStatusMessage = !doEditStatusMessage;
                                    });
                                  },
                                )
                              ]),
                            ),
                          ]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: SelectableText(context.i18n.privacySettings,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: lightTextColor,
                                      )),
                            ),
                            SizedBox(height: 10),
                            SwitchListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              activeThumbColor: primaryColor,
                              value: shareActivityData,
                              onChanged: (value) {
                                setState(() {
                                  shareActivityData = value;
                                  userRepository.updateShareActivityData(shareActivityData, shareActiveMinutes);
                                  MatomoTracker.instance.trackEvent(
                                    eventInfo: EventInfo(
                                        category: EVENT_CATEGORY_PATIENT_STATE, name: EVENT_NAME_UPDATE, action: "Set share activity data to $value"),
                                  );
                                });
                              },
                              title: Transform.translate(
                                offset: const Offset(-12, 0),
                                child: Text(context.i18n.shareActivityData, style: Theme.of(context).textTheme.bodyLarge),
                              ),
                            ),
                            if (shareActivityData) ...[
                              RadioGroup<bool>(
                                groupValue: shareActiveMinutes,
                                onChanged: (bool? value) {
                                  setState(() {
                                    shareActiveMinutes = value ?? true;
                                    userRepository.updateShareActivityData(shareActivityData, shareActiveMinutes);
                                  });
                                },
                                child: Column(
                                  children: [
                                    ...[true, false]
                                        .map((value) => RadioListTile<bool>(
                                              value: value,
                                              contentPadding: EdgeInsets.only(left: 5),
                                              activeColor: primaryColor,
                                              dense: true,
                                              visualDensity: const VisualDensity(
                                                  horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                              title: Transform.translate(
                                                offset: const Offset(-12, 0),
                                                child: Text(
                                                  value
                                                      ? institution?.institutionFocus?.isKlimafit() ?? false
                                                          ? context.i18n.activeMinutesShowKlimafit
                                                          : context.i18n.activeMinutesShow
                                                      : institution?.institutionFocus?.isKlimafit() ?? false
                                                          ? context.i18n.activeMinutesHideKlimafit
                                                          : context.i18n.activeMinutesHide,
                                                  style: Theme.of(context).textTheme.bodyLarge,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ],
                                ),
                              ),
                            ],
                          ]),
                        ),
                        SizedBox(height: 10),
                      ],
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: SelectableText(context.i18n.trainingState,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: lightTextColor,
                                      )),
                            ),
                            SizedBox(height: 10),
                            RadioGroup<PatientState>(
                              groupValue: patientState,
                              onChanged: (PatientState? value) {
                                setState(() {
                                  patientState = value ?? PatientState.NO_STATE;
                                  userRepository.storePatientState(patient.id!, patientState);
                                  MatomoTracker.instance.trackEvent(
                                    eventInfo: EventInfo(
                                      category: EVENT_CATEGORY_PATIENT_STATE,
                                      name: EVENT_NAME_UPDATE,
                                      action: "Set Patient State to $patientState",
                                    ),
                                  );
                                });
                              },
                              child: Column(
                                children: [
                                  ...[PatientState.NO_STATE, PatientState.INAPPROPRIATE_TRAINING_PLAN, PatientState.ON_VACATION, PatientState.SICK]
                                      .map((entry) => RadioListTile<PatientState>(
                                            value: entry,
                                            toggleable: true,
                                            contentPadding: EdgeInsets.only(left: 5),
                                            activeColor: primaryColor,
                                            dense: true,
                                            visualDensity:
                                                const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                            title: Transform.translate(
                                              offset: const Offset(-12, 0),
                                              child: Text(entry.getTranslatedText(context), style: Theme.of(context).textTheme.bodyLarge),
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SelectableText(context.i18n.myHealthData,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: lightTextColor,
                                          )),
                                ),
                                SizedBox(height: 5),
                                PatientInfoRow(title: context.i18n.birthdate, value: patient.birthDate!),
                                PatientInfoRow(title: context.i18n.bodyHeight, value: patient.height.toString(), unit: "cm"),
                                PatientInfoRow(title: context.i18n.bodyWeight, value: patient.weight.toString(), unit: "kg"),
                                SizedBox(height: 10),
                                PatientInfoRow(
                                  title: context.i18n.activityClass,
                                  value: patient.activityClass.toString(),
                                ),
                                PatientInfoRow(title: context.i18n.maximumHeartRateShort, value: patient.maximumHeartRate.toString(), unit: "bpm"),
                                if ((patient.maximumBloodPressure ?? "").isNotEmpty)
                                  PatientInfoRow(
                                      title: context.i18n.maximumBloodPressureShort, value: patient.maximumBloodPressure.toString(), unit: "mmHg"),
                                if ((patient.maximumPerformance ?? 0) > 0)
                                  PatientInfoRow(
                                      title: context.i18n.maximumPerformanceShort, value: patient.maximumPerformance.toString(), unit: "Watt/kg"),
                                SizedBox(height: 10),
                                if ((patient.maximumOxygenConsumption ?? 0) > 0)
                                  PatientInfoRow(
                                      title: context.i18n.maximumOxygenShort, value: patient.maximumOxygenConsumption.toString(), unit: "ml/kg/min"),
                                PatientInfoRow(
                                  title: context.i18n.comorbidities,
                                  value: ((patient.diseases ?? "-") == "-") || patient.diseases!.isEmpty ? context.i18n.none : patient.diseases!,
                                ),
                                PatientInfoRow(
                                  title: context.i18n.medication,
                                  value:
                                      ((patient.medication ?? "-") == "-") || patient.medication!.isEmpty ? context.i18n.none : patient.medication!,
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: containerWidth - 22,
                                  child: ElevatedButton(
                                    key: Key(KEY_PATIENT_PROFILE_REQUEST_CHANGES),
                                    style: getElevatedButtonStyle(context),
                                    child: Text(context.i18n.requestChanges.toUpperCase()),
                                    onPressed: () => showChangeDataDialog(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        key: Key(KEY_PATIENT_PROFILE_BUTTON_CHANGE_PASSWORD),
                        style: getElevatedButtonStyle(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(context.i18n.changePassword.toUpperCase())],
                        ),
                        onPressed: () => showChangePasswordDialog(),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: getElevatedButtonStyle(context, backgroundColor: errorColor),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context.i18n.requestProfileDeletion.toUpperCase()),
                          ],
                        ),
                        onPressed: () => showAlertDialog(context, context.i18n.requestProfileDeletionText, context.i18n.requestProfileDeletionButton,
                            context.i18n.cancel, () => deleteProfile(size.isMobile)),
                      ),
                      SizedBox(height: 50),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  String get traceablePageName => "Patient Data Page";
}

class PatientInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  PatientInfoRow({Key? key, required this.title, required this.value, this.unit = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
      child: SelectableText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: title + ": ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: value.isEmpty ? "-" : "$value ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(
              text: unit,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
