// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

//import 'dart:html';
import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/apt_subtitle.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/health_professionals/health_professionals_table.dart';
import 'package:aptapp/institution/bloc/institution_repository.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:kiwi/kiwi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InstitutionHealthcareProfessionalsPage extends StatefulWidget {
  final String institutionId;
  InstitutionHealthcareProfessionalsPage({
    Key? key,
    required this.institutionId,
  }) : super(key: key);

  @override
  _InstitutionHealthcareProfessionalsPageState createState() => _InstitutionHealthcareProfessionalsPageState();
}

class _InstitutionHealthcareProfessionalsPageState extends State<InstitutionHealthcareProfessionalsPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  List users = [];
  List<InstitutionDTO> institutions = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(FetchHealthcareProfessionalsEvent(institutionId: widget.institutionId));
  }

  addUser(InstitutionDTO institution) {
    context.beamToNamed(RouterService.healthcareProfessionalAddRoute(institutionId: institution.id!), data: {"institution": institution});
  }

  getPatients(HealthcareProfessionalGetDTO user, InstitutionDTO institution) {
    context.beamToNamed(RouterService.patientsRoute(institutionId: institution.id!, healthcareProfessionalId: user.id!));
  }

  void handleSnackbar(UserState state, SizingInformation size, BuildContext context) {
    var snackBar;
    if (state is AdminAddedHPState) {
      snackBar = getSnackbar(context.i18n.addedHealthcareProfessional, size.isMobile, context);
    } else if (state is AdminUpdatedHPState) {
      snackBar = getSnackbar(context.i18n.updatedHealthcareProfessional, size.isMobile, context);
    } else if (state is AdminDeletedHPState) {
      snackBar = getSnackbar(context.i18n.deletedHealthcareProfessional, size.isMobile, context);
    } else if (state is UserAlreadPresetState) {
      snackBar = getSnackbar(
        context.i18n.validationDuplicateEmail,
        size.isMobile,
        context,
        error: true,
      );
    } else if (state is UsersErrorState) {
      print(state.message);
      snackBar = getSnackbar(
        context.i18n.error,
        size.isMobile,
        context,
        error: true,
      );
    }

    if (snackBar != null) {
      snackBar.show(context);
      snackBar = null;
    }
  }

  showOverrideDatabaseDialog(SizingInformation size) {
    final List<InstitutionImportType> importTypes = [];
    final InstitutionRepository institutionRepository = KiwiContainer().resolve<InstitutionRepository>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(context.i18n.overwriteDatabase),
              content: Wrap(
                children: [
                  Text(context.i18n.overwriteDatabaseText),
                  SizedBox(height: 50),
                  ...[
                    InstitutionImportType.EXERCISES,
                    InstitutionImportType.MESSAGES,
                    InstitutionImportType.VIDEOS,
                    InstitutionImportType.EXTERNAL_APPS
                  ]
                      .map(
                        (e) => CheckboxListTile(
                          title: Text(e.getTranslatedText(context)),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.black,
                          value: importTypes.contains(e),
                          onChanged: (_) {
                            setState(() {
                              if (importTypes.contains(e)) {
                                importTypes.remove(e);
                              } else {
                                importTypes.add(e);
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                      .toList(),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: importTypes.isEmpty
                          ? ButtonStyle()
                          : ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) => errorColor,
                              ),
                            ),
                      child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.overwriteDataIrreversibly)),
                      onPressed: importTypes.isEmpty
                          ? null
                          : () {
                              Navigator.of(context, rootNavigator: true).pop();
                              institutionRepository
                                  .importExerciseData(InstitutionImportDTO(
                                institutionId: widget.institutionId,
                                deleteData: true,
                                importTypes: importTypes,
                              ))
                                  .then((_) {
                                getSnackbar(context.i18n.databaseOverwritten, size.isMobile, context).show(context);
                              });
                            }),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    key: Key(KEY_BUTTON_CANCEL),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => errorColor,
                      ),
                    ),
                    child: FittedBox(fit: BoxFit.contain, child: Text(context.i18n.cancel)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        final userRepository = KiwiContainer().resolve<UserRepository>();
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            handleSnackbar(state, size, context);
          },
          builder: (context, state) {
            return AptLayout(
              key: Key(KEY_HEALTHCARE_PROFESSIONALS_SCROLL_VIEW),
              breadCrumb: [
                if (userRepository.userRole == UserRole.ADMINISTRATOR)
                  BreadCrumbItem(
                    content: TextButton(
                      key: Key(KEY_HEALTHCARE_PROFESSIONALS_BREAD_CRUMB_INSTITUTIONS),
                      onPressed: () => context.beamToNamed(RouterService.institutionsRoute()),
                      child: Text(
                        i18n.institutionOverview,
                        style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                if (userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR)
                  BreadCrumbItem(
                    content: SelectableText(
                      i18n.institutionOverview,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
                if (userRepository.userRole == UserRole.ADMINISTRATOR && state is FetchedHealthcareProfessionalsState)
                  BreadCrumbItem(
                    content: SelectableText(
                      state.users.institution!.name!,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
              ],
              addButton: RoundedIconButton(
                  title: context.i18n.addHealthcareProfessional,
                  callback: state is FetchedHealthcareProfessionalsState ? () => addUser(state.users.institution!) : null),
              subtitle: AptSubtitle(
                left: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Icon(
                    MdiIcons.hospitalBuilding,
                    color: Colors.black,
                    size: 56,
                  ),
                  title: Text(
                    state is FetchedHealthcareProfessionalsState ? state.users.institution!.name! : context.i18n.institution,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(state is FetchedHealthcareProfessionalsState
                      ? "${context.i18n.administrator}: ${(state.users.institution!.firstName ?? "")} ${(state.users.institution!.lastName ?? "")}"
                      : "${context.i18n.administrator}:"),
                ),
                right: Wrap(
                  children: [
                    if (userRepository.userRole == UserRole.ADMINISTRATOR)
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          key: Key(KEY_HEALTHCARE_PROFESSIONALS_BUTTON_OVERWRITE_DATABSE),
                          onPressed: () => showOverrideDatabaseDialog(size),
                          child: Text(context.i18n.overwriteDatabase.toUpperCase()),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: ElevatedButton(
                        key: Key(KEY_HEALTHCARE_PROFESSIONALS_BUTTON_EDIT_INSTITUTION),
                        onPressed: state is FetchedHealthcareProfessionalsState
                            ? () => context.beamToNamed(
                                  RouterService.institutionsEditRoute(id: state.users.institution!.id!),
                                  data: {
                                    'institution': state.users.institution,
                                  },
                                )
                            : null,
                        child: Text(context.i18n.editInstitution.toUpperCase()),
                      ),
                    ),
                  ],
                ),
                tableHeadline: context.i18n.healthcareProfessionals,
              ),
              children: [
                if (state is FetchedHealthcareProfessionalsState)
                  HealthProfessionalsTable(
                    healthcareProfessionalsOverview: state.users,
                    editAction: (user, institution) => getPatients(user, institution),
                    size: size,
                  ),
                if (!(state is FetchedHealthcareProfessionalsState))
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  String get traceablePageName => "Institution Healthcare Professionals Page";
}
