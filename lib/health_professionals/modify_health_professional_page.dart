// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'dart:io';

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/user/user_controller_repository.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/delete_button.dart';
import 'package:aptapp/widget/image_form_field.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';

import '../main.dart';
import '../widget/form_field_padding.dart';

class ModifyHealthProfessionalPage extends StatefulWidget {
  final bool edit;
  final HealthcareProfessionalGetDTO? user;
  final String? institutionId;
  final UserBloc? adminBloc;
  final String? userId;

  ModifyHealthProfessionalPage({
    Key? key,
    required this.edit,
    this.user,
    this.adminBloc,
    this.institutionId,
    this.userId,
  }) : super(key: key);

  @override
  _ModifyHealthProfessionalPageState createState() => _ModifyHealthProfessionalPageState();
}

class _ModifyHealthProfessionalPageState extends State<ModifyHealthProfessionalPage> with TraceablePageMixin {
  final _addUserFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final jobController = TextEditingController();
  final emailController = TextEditingController();
  final photoController = TextEditingController();
  UserBloc? userBloc;
  List<PlatformFile> _paths = [];
  MultipartFile? profilePicture;
  FileGetDTO? userPicture;
  String uploadedPicturePath = "";
  final userRepository = KiwiContainer().resolve<UserRepository>();
  final userApi = new UserControllerApi(apiClient);
  InstitutionCountDTO userCount = new InstitutionCountDTO();
  HealthcareProfessionalGetDTO? user;
  bool hasChanges = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    jobController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userBloc = widget.adminBloc ?? BlocProvider.of<UserBloc>(context);
    getUser();
  }

  addUser() {
    if (_addUserFormKey.currentState!.validate()) {
      final userRepository = KiwiContainer().resolve<UserRepository>();
      Map<String, dynamic> newProf = {
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "id": null,
        "institutionId": widget.institutionId ?? userRepository.currentUser.institutionId,
        "jobName": jobController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "userPictureUrl": photoController.text.trim(),
      };
      var newProfessional = HealthcareProfessionalGetDTO.fromJson(newProf);
      userBloc!.add(AddUserEvent(newUser: newProfessional, picture: profilePicture));
      goBack();
    }
  }

  updateUser() {
    if (_addUserFormKey.currentState!.validate()) {
      final userRepository = KiwiContainer().resolve<UserRepository>();
      Map<String, dynamic> updateUser = {
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "id": this.user!.id,
        "institutionId": widget.institutionId ?? userRepository.currentUser.institutionId,
        "jobName": jobController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "userPictureUrl": photoController.text.trim(),
      };

      this.user = HealthcareProfessionalGetDTO.fromJson(updateUser);
      userBloc!.add(UpdateUserEvent(id: this.user!.id!, user: this.user, picture: profilePicture));
      goBack();
    }
  }

  deleteUser() {
    userBloc!.add(DeleteHealthcareProfessionalEvent(id: user!.id!, institutionId: user!.institutionId!));
    context.beamToNamed(RouterService.healthcareProfessionalsRoute(institutionId: widget.institutionId));
  }

  getUser() async {
    if (widget.edit) {
      if (widget.user != null) {
        user = widget.user;
      } else {
        user = await userApi.getHealthcareProfessionalById(widget.userId!);
      }
      firstNameController.text = user!.firstName ?? "";
      lastNameController.text = user!.lastName ?? "";
      emailController.text = user!.email ?? "";
      jobController.text = user!.jobName ?? "";

      final UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();
      final List results = await Future.wait([
        userApi.getPatientUserCountByHealthcareProfessionalId(user!.id!),
        userControllerRepository.getUserPicture(id: user!.id!, userRole: UserRole.HEALTHCARE_PROFESSIONAL)
      ]);
      if (this.mounted) {
        setState(() {
          userCount = results[0];
          userPicture = results[1];
        });
      }
    }
  }

  goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed(user != null
          ? RouterService.patientsRoute(institutionId: widget.institutionId!, healthcareProfessionalId: user!.id!)
          : RouterService.healthcareProfessionalsRoute(institutionId: widget.institutionId!));
    }
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
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

  uploadImage() async {
    _openFileExplorer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AptLayout(
      border: false,
      fixedHeight: false,
      breadCrumb: <BreadCrumbItem>[
        BreadCrumbItem(
          content: Padding(
            padding: EdgeInsets.only(left: 10),
            child: SelectableText(
              context.i18n.healthcareProfessional,
              style: getBreadCrumbStyle(context),
            ),
          ),
        ),
      ],
      children: [
        Form(
          key: _addUserFormKey,
          child: widget.edit && user == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FormFieldPadding(
                      child: TextFormField(
                        controller: firstNameController,
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
                        controller: jobController,
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
                          hintText: context.i18n.jobName,
                          labelText: context.i18n.jobName + ' *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    FormFieldPadding(
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if ((value ?? "").isEmpty || !EmailValidator.validate((value ?? "").trim())) {
                            return context.i18n.validationEmail;
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
                    ImageFormField(controller: photoController, callback: uploadImage),
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
                    if ((userPicture?.exists ?? false) || uploadedPicturePath.isNotEmpty)
                      FormFieldPadding(
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
                      ),
                    FormFieldPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.edit
                              ? SaveButton(title: context.i18n.save.toUpperCase(), callback: updateUser)
                              : SaveButton(title: context.i18n.create.toUpperCase(), callback: addUser),
                          SizedBox(width: width * 0.01),
                          CancelButton(
                            callback: () => goBack(),
                            hasChanges: this.hasChanges,
                          ),
                          SizedBox(width: width * 0.01),
                          if (widget.edit)
                            DeleteButton(
                              callback: deleteUser,
                              confirmationTitle: context.i18n.deleteMessageHealthcareProfessionalsTitle,
                              confirmationText: context.i18n
                                  .deleteMessageHealthcareProfessionals("${user!.firstName} ${user!.lastName}", userCount.patientCount ?? 0),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }

  String get traceablePageName => "Modify Health Professional Page";
}
