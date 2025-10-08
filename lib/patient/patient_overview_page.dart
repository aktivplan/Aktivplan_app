// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/apt_subtitle.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/user/user_controller_repository.dart';
import 'package:aptapp/utils/activity_helpers.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/enums.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/cancel_button.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:aptapp/widget/save_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:styled_text/styled_text.dart';

class PatientOverviewPage extends StatefulWidget {
  final String healthcareProfessionalId;
  final String? institutionId;

  PatientOverviewPage({
    Key? key,
    required this.healthcareProfessionalId,
    this.institutionId,
  }) : super(key: key);

  @override
  _PatientOverviewPageState createState() => _PatientOverviewPageState();
}

class _PatientOverviewPageState extends State<PatientOverviewPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  UserBloc? userBloc;
  List<PatientGetDTO> users = [];
  PatientSelectMode selectMode = PatientSelectMode.None;
  List<String> selectedPatientIds = [];
  List<String> checkedPatientIds = [];
  String institutionId = "";
  String healthcareProfessionalId = "";
  List<HealthcareProfessionalGetDTO> healthcareProfessionals = [];
  String newHealthcareProfessionalId = "";
  final healthcareProfessionalController = TextEditingController();
  bool hasChanges = false;
  bool handingOver = false;
  bool canHandOver = false;
  FileGetDTO userPicture = FileGetDTO(exists: false);
  bool showThreeWeekState = false;
  FocusNode dropdownFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    sortColumn(0, false);
    newHealthcareProfessionalId = "";
    if (userRepository.userRole == UserRole.ADMINISTRATOR || userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      UserControllerRepository userControllerRepository = KiwiContainer().resolve<UserControllerRepository>();
      if (widget.healthcareProfessionalId.isNotEmpty) {
        userControllerRepository.getUserPicture(id: widget.healthcareProfessionalId, userRole: UserRole.HEALTHCARE_PROFESSIONAL).then((value) {
          setState(() {
            userPicture = value!;
          });
        });
      }
      userControllerRepository.getHealthcareProfessionals(institutionId: widget.institutionId).then((value) {
        if (value!.users.length > 1) {
          setState(() {
            canHandOver = true;
          });
        }
      });
    }
    context.read<UserBloc>().stream.listen((state) {
      if (state is FetchedPatientsState) {
        setState(() {
          showThreeWeekState = showThreeWeekStateForPatient(state.users.institution!);
        });
      }
    });
  }

  sortColumn(int columnIndex, bool ascending) {
    setState(() {
      isAscending = ascending;
      selectedColumn = columnIndex;
    });
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => (a.lastName ?? "").toLowerCase().compareTo((b.lastName ?? "").toLowerCase()));
      } else {
        users.sort((a, b) => (b.lastName ?? "").toLowerCase().compareTo((a.lastName ?? "").toLowerCase()));
      }
    } else if (columnIndex == 1) {
      if (ascending) {
        users.sort((a, b) => (a.registerDate ?? "").compareTo((b.registerDate ?? "")));
      } else {
        users.sort((a, b) => (b.registerDate ?? "").compareTo((a.registerDate ?? "")));
      }
    } else if (columnIndex == 2) {
      if (ascending) {
        users.sort((a, b) => (a.lastActiveDate ?? "").compareTo((b.lastActiveDate ?? "").toLowerCase()));
      } else {
        users.sort((a, b) => (b.lastActiveDate ?? "").toLowerCase().compareTo((a.lastActiveDate ?? "").toLowerCase()));
      }
    } else {
      if (ascending) {
        users.sort((a, b) => (a.activityPercentageLastFourWeeks ?? -1).compareTo((b.activityPercentageLastFourWeeks ?? -1)));
      } else {
        users.sort((a, b) => (b.activityPercentageLastFourWeeks ?? -1).compareTo((a.activityPercentageLastFourWeeks ?? -1)));
      }
    }
  }

  exportDocumentation(user, type) {
    context.beamToNamed("/patients/${user.id}/export/$type");
  }

  goToPatientCalendar(user) {
    context.beamToNamed(
      "/patients/${user.id}/calendar",
      data: {
        "patient": user,
      },
      beamBackOnPop: true,
    );
  }

  addUser() {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    if (userRepository.userRole == UserRole.ADMINISTRATOR) {
      context.beamToNamed('/institutions/$institutionId/healthcare-professionals/${widget.healthcareProfessionalId}/patients/add');
    } else if (userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      context.beamToReplacementNamed(
        "/professionals/${widget.healthcareProfessionalId}/patients/add",
        data: {
          "healthcareProfessionalId": widget.healthcareProfessionalId,
        },
      );
    } else {
      context.beamToNamed("/patients/add");
    }
  }

  getPatientsInfoLine(SizingInformation size) {
    if (size.isMobile && selectMode == PatientSelectMode.None) {
      return Container();
    }
    Widget completionText = StyledText(
      text: showThreeWeekState ? context.i18n.patientsInfoActiveMinutesThreeWeeks : context.i18n.patientsInfoActiveMinutes,
      tags: {
        'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
        'trafficLight1': StyledTextWidgetTag(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: getTrafficLightForPercentage(100, 15),
          ),
        ),
        'trafficLight2': StyledTextWidgetTag(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: getTrafficLightForPercentage(50, 15),
          ),
        ),
        'trafficLight3': StyledTextWidgetTag(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: getTrafficLightForPercentage(0, 15),
          ),
        )
      },
    );
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 5),
      child: selectMode == PatientSelectMode.None
          ? Align(alignment: Alignment.centerRight, child: completionText)
          : Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CheckboxListTile(
                        activeColor: Colors.black,
                        title: Text(
                          context.i18n.allPatients,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: selectedPatientIds.length == users.length && selectedPatientIds.length > 0,
                        onChanged: (selected) {
                          setState(() {
                            if (selectedPatientIds.length == users.length) {
                              selectedPatientIds.clear();
                            } else {
                              selectedPatientIds = users.map((e) => e.id!).toList();
                            }
                            this.hasChanges = true;
                          });
                        }),
                  ),
                ),
                if (size.screenSize.width > 1400) completionText
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final userRepository = KiwiContainer().resolve<UserRepository>();
    String headline = userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL ? context.i18n.patientOverview : context.i18n.patients;
    if (selectMode == PatientSelectMode.Handhover) {
      headline = context.i18n.patientHandover;
    }
    return ResponsiveBuilder(
      builder: (context, size) {
        double horizontalPadding = size.isDesktop
            ? width * 0.2
            : size.isTablet
                ? width * 0.03
                : width * 0.01;
        return BlocConsumer<UserBloc, UserState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            var snackBar;
            if (state is AddedPatientState) {
              snackBar = getSnackbar(context.i18n.addedPatient, size.isMobile, context);
            } else if (state is UpdatedPatientState) {
              snackBar = getSnackbar(context.i18n.updatedPatient, size.isMobile, context);
            } else if (state is DeletedPatientState) {
              snackBar = getSnackbar(context.i18n.deletedPatient, size.isMobile, context);
            } else if (state is UserAlreadPresetState) {
              snackBar = getSnackbar(
                context.i18n.validationDuplicateEmail,
                size.isMobile,
                context,
                error: true,
              );
            } else if (state is UsersErrorState) {
              snackBar = getSnackbar(
                context.i18n.error,
                size.isMobile,
                context,
                error: true,
              );
            } else if (state is ChangedHealthcareProfessionalForPatientsState) {
              handingOver = false;
              selectedPatientIds.clear();
              hasChanges = false;
              snackBar = getSnackbar(
                  state.patientNames.length == 1
                      ? context.i18n.patientHandoverCompleteSingleText(state.newHealthcareProfessionalName, state.patientNames.first)
                      : context.i18n.patientHandoverCompleteMultipleText(state.newHealthcareProfessionalName, state.patientNames.join(", ")),
                  size.isMobile,
                  context);
            }
            if (snackBar != null) {
              snackBar.show(context);
              snackBar = null;
            }
          },
          buildWhen: (previousState, state) {
            return state is FetchedPatientsState;
          },
          builder: (context, state) {
            return AptLayout(
                key: Key(KEY_PATIENTS_SCROLL_VIEW),
                breadCrumb: getBreadCrumb(userRepository, context, state, headline),
                spacing: 10,
                halfHeight: selectMode != PatientSelectMode.None,
                border: true,
                fixedHeight: true,
                subtitle: userRepository.userRole == UserRole.ADMINISTRATOR || userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR
                    ? Column(
                        children: [
                          AptSubtitle(
                            left: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: (userPicture.exists ?? false)
                                  ? CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(userPicture.url!),
                                    )
                                  : Icon(
                                      Icons.account_circle,
                                      color: Colors.grey,
                                      size: 56,
                                    ),
                              title: Text(
                                state is FetchedPatientsState
                                    ? (state.users.healthcareProfessional?.firstName ?? "") +
                                        " " +
                                        (state.users.healthcareProfessional?.lastName ?? "")
                                    : '',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                state is FetchedPatientsState ? state.users.healthcareProfessional?.jobName ?? "" : "",
                              ),
                            ),
                            right: ElevatedButton(
                                key: Key(KEY_PATIENTS_BUTTON_EDIT_HEALTH_EXPERT),
                                onPressed: state is FetchedPatientsState
                                    ? () => context.beamToNamed(
                                          RouterService.healthcareProfessionalEditRoute(
                                              institutionId: state.users.institution!.id!,
                                              healthcareProfessionalId: state.users.healthcareProfessional!.id!),
                                          data: {'user': state.users.healthcareProfessional, 'institution': state.users.institution},
                                        )
                                    : null,
                                child: Text(context.i18n.editHealthcareProfessional.toUpperCase())),
                            tableHeadline: headline,
                          ),
                          getPatientsInfoLine(size),
                        ],
                      )
                    : getPatientsInfoLine(size),
                addButton: selectMode == PatientSelectMode.None
                    ? RoundedIconButton(
                        title: context.i18n.addPatient,
                        callback: addUser,
                      )
                    : null,
                children: [
                  Builder(
                    builder: (context) {
                      if (state is FetchedPatientsState) {
                        users = state.users.users;
                        institutionId = state.users.institution!.id!;
                        healthcareProfessionalId = state.users.healthcareProfessional!.id!;
                        if (users.isEmpty)
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.isDesktop ? width * 0.5 : width - (2 * horizontalPadding),
                                height: height * 0.5,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SelectableText(
                                      context.i18n.noPatients,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: lightTextColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );

                        return DataTable(
                          showCheckboxColumn: false,
                          showBottomBorder: true,
                          sortAscending: isAscending,
                          sortColumnIndex: selectedColumn,
                          columns: [
                            AptDataColumn(
                              label: Text(
                                context.i18n.name,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              selectedColumnIndex: selectedColumn,
                              dataColoumnIndex: 0,
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending);
                              },
                            ),
                            if (!size.isMobile && !size.isTablet)
                              AptDataColumn(
                                label: Text(
                                  context.i18n.addedAt,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                selectedColumnIndex: selectedColumn,
                                dataColoumnIndex: 1,
                                onSort: (columnIndex, ascending) {
                                  sortColumn(columnIndex, ascending);
                                },
                              ),
                            if (!size.isMobile && !size.isTablet)
                              AptDataColumn(
                                selectedColumnIndex: selectedColumn,
                                dataColoumnIndex: 2,
                                label: Text(
                                  context.i18n.lastActiveAt,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                onSort: (columnIndex, ascending) {
                                  sortColumn(columnIndex, ascending);
                                },
                              ),
                            if (!size.isMobile)
                              AptDataColumn(
                                selectedColumnIndex: selectedColumn,
                                dataColoumnIndex: 3,
                                label: Text(
                                  showThreeWeekState ? context.i18n.patientStateActiveMinutes : context.i18n.patientStatePlannedActiveMinutes,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                onSort: (columnIndex, ascending) {
                                  sortColumn(columnIndex, ascending);
                                },
                              ),
                          ],
                          rows: users
                              .map(
                                (user) => DataRow(
                                  onSelectChanged: (selected) {
                                    if (selectMode != PatientSelectMode.None) {
                                      togglePatientSelection(user.id!);
                                    } else {
                                      goToPatientCalendar(user);
                                    }
                                  },
                                  cells: [
                                    DataCell(
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                child: Wrap(
                                                  children: [
                                                    if (selectMode != PatientSelectMode.None)
                                                      CheckboxListTile(
                                                          activeColor: Colors.black,
                                                          title: Text(
                                                            "${user.lastName} ${user.firstName}",
                                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                                          ),
                                                          controlAffinity: ListTileControlAffinity.leading,
                                                          value: selectedPatientIds.contains(user.id),
                                                          onChanged: (selected) => togglePatientSelection(user.id!)),
                                                    if (selectMode == PatientSelectMode.None)
                                                      Text(
                                                        "${user.lastName} ${user.firstName}",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (size.isMobile)
                                              Wrap(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: TextButton(
                                                        onPressed: () => exportDocumentation(user, 'pdf'),
                                                        child: Text("PDF",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(letterSpacing: 1.1, decoration: TextDecoration.underline))),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: TextButton(
                                                        onPressed: () => exportDocumentation(user, 'csv'),
                                                        child: Text("CSV",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(letterSpacing: 1.1, decoration: TextDecoration.underline))),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.arrow_forward_ios),
                                                    onPressed: () => goToPatientCalendar(user),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (!size.isMobile && !size.isTablet)
                                      DataCell(
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        "${germanDateFormat.format(
                                                          englishDateFormat.parse(user.registerDate!),
                                                        )}",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                              letterSpacing: 1.1,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (!size.isMobile && !size.isTablet)
                                      DataCell(
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        (user.lastActiveDate ?? "").isNotEmpty
                                                            ? "${germanDateFormat.format(
                                                                englishDateFormat.parse(user.lastActiveDate!),
                                                              )}"
                                                            : "-",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                              letterSpacing: 1.1,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (!size.isMobile)
                                      DataCell(
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              children: [
                                                if ((user.activityPercentageLastFourWeeks ?? -1) >= 0 && !showThreeWeekState)
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10),
                                                    child: getTrafficLightForPercentage(user.activityPercentageLastFourWeeks!, 25),
                                                  ),
                                                if ((user.activityPercentageLastThreeWeeks ?? -1) >= 0 && showThreeWeekState)
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10),
                                                    child: getTrafficLightForPercentage(user.activityPercentageLastThreeWeeks!, 25),
                                                  ),
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      if ((user.activityPercentageLastFourWeeks ?? -1) >= 0 && !showThreeWeekState)
                                                        Text("${user.activityPercentageLastFourWeeks}%"),
                                                      if ((user.activityPercentageLastThreeWeeks ?? -1) >= 0 && showThreeWeekState)
                                                        Text(context.i18n.patientStateActiveMinutesPercentage(
                                                            user.activityPercentageLastThreeWeeks!, user.activityPercentageLastThreeWeeksPlanned!)),
                                                      if (user.patientState != PatientState.NO_STATE)
                                                        Padding(
                                                          padding: EdgeInsets.only(top: (user.activityPercentageLastFourWeeks ?? -1) >= 0 ? 5 : 0),
                                                          child: StyledText(
                                                            text: "<b>${context.i18n.state}</b>: ${user.patientState!.getTranslatedText(context)}",
                                                            tags: {'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold))},
                                                          ),
                                                        ),
                                                    ]),
                                              ],
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: TextButton(
                                                      onPressed: () => exportDocumentation(user, 'pdf'),
                                                      child: Text("PDF",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(letterSpacing: 1.1, decoration: TextDecoration.underline))),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: TextButton(
                                                      onPressed: () => exportDocumentation(user, 'csv'),
                                                      child: Text("CSV",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(letterSpacing: 1.1, decoration: TextDecoration.underline))),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.arrow_forward_ios),
                                                  onPressed: () => goToPatientCalendar(user),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
                outsideWidget: outsideWidget(size));
          },
        );
      },
    );
  }

  Widget? outsideWidget(SizingInformation size) {
    if (selectMode == PatientSelectMode.Handhover) {
      return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is FetchedHealthcareProfessionalsState) {
                  healthcareProfessionals = state.users.users.where((element) => element.id != healthcareProfessionalId).toList();
                }
                if (healthcareProfessionals.isNotEmpty) {
                  return TypeAheadField<HealthcareProfessionalGetDTO>(
                    focusNode: dropdownFocusNode,
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.firstName! + " " + suggestion.lastName!),
                      );
                    },
                    onSelected: (suggestion) {
                      healthcareProfessionalController.text = suggestion.firstName! + " " + suggestion.lastName!;
                      dropdownFocusNode.unfocus();
                      setState(() {
                        newHealthcareProfessionalId = suggestion.id!;
                        this.hasChanges = true;
                      });
                    },
                    suggestionsCallback: (pattern) {
                      final toReturn = healthcareProfessionals
                          .where((element) => ((element.firstName! + " " + element.lastName!).toLowerCase().contains(pattern.toLowerCase())))
                          .toList();
                      return toReturn.isEmpty ? null : toReturn;
                    },
                    controller: healthcareProfessionalController,
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: healthcareProfessionalController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: context.i18n.responsibleHealthExpert,
                          labelText: context.i18n.responsibleHealthExpert + " *",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: datatableBorderColor,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            SizedBox(height: 10),
            if (!handingOver)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SaveButton(
                    title: context.i18n.handOver.toUpperCase(),
                    disabled: this.selectedPatientIds.length == 0 || newHealthcareProfessionalId.isEmpty,
                    callback: () {
                      setState(() {
                        handingOver = true;
                      });
                      BlocProvider.of<UserBloc>(context)
                        ..add(ChangeHealthcareProfessionalForPatientsEvent(
                            changeHealthcareProfessionalDTO: ChangeHealthcareProfessionalDTO(
                                healthcareProfessionalId: newHealthcareProfessionalId, patientIds: this.selectedPatientIds),
                            originalHealthcareProfessionalId: healthcareProfessionalId,
                            newHealthcareProfessionalName: healthcareProfessionalController.text,
                            patientNames: users
                                .where((element) => selectedPatientIds.indexOf(element.id!) >= 0)
                                .map((e) => "${e.firstName} ${e.lastName}")
                                .toList()));
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CancelButton(
                    callback: () {
                      setState(() {
                        selectMode = PatientSelectMode.None;
                      });
                    },
                    hasChanges: this.hasChanges,
                  )
                ],
              ),
            if (handingOver) CircularProgressIndicator()
          ],
        ),
      );
    }

    if (userRepository.userRole == UserRole.ADMINISTRATOR || userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      return Container(
        transform: Matrix4.translationValues(0, size.isMobile ? 0 : -20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              key: Key(KEY_PATIENTS_BUTTON_HANDOVER),
              onPressed: !canHandOver
                  ? null
                  : () {
                      BlocProvider.of<UserBloc>(context)..add(FetchHealthcareProfessionalsEvent(institutionId: institutionId));
                      setState(() {
                        selectedPatientIds.clear();
                        selectMode = PatientSelectMode.Handhover;
                        healthcareProfessionalController.clear();
                        hasChanges = false;
                      });
                    },
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2, right: 5, left: 5),
                    child: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                  Text(
                    context.i18n.patientHandover,
                    style: canHandOver ? getBreadCrumbStyle(context) : getBreadCrumbStyle(context)?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }

  void togglePatientSelection(String id) {
    setState(
      () {
        if (!selectedPatientIds.contains(id)) {
          selectedPatientIds.add(id);
        } else {
          selectedPatientIds.remove(id);
        }
        this.hasChanges = true;
      },
    );
  }

  List<BreadCrumbItem> getBreadCrumb(UserRepository userRepository, BuildContext context, UserState state, String headline) {
    return [
      if (userRepository.userRole == UserRole.ADMINISTRATOR)
        BreadCrumbItem(
          content: TextButton(
            onPressed: () => context.beamToNamed(RouterService.institutionsRoute()),
            child: Text(
              context.i18n.institutionOverview,
              style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      if (userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR)
        BreadCrumbItem(
          content: TextButton(
            key: Key(KEY_PATIENTS_BREAD_CRUMB_INSTITUTION),
            onPressed: () => context.beamToNamed(RouterService.healthcareProfessionalsRoute()),
            child: Text(
              context.i18n.institutionOverview,
              style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      if (userRepository.userRole == UserRole.ADMINISTRATOR && state is FetchedPatientsState)
        BreadCrumbItem(
          content: TextButton(
            key: Key(KEY_PATIENTS_BREAD_CRUMB_INSTITUTION),
            onPressed: () => context.beamToNamed(RouterService.healthcareProfessionalsRoute(institutionId: state.users.institution!.id)),
            child: Text(
              state.users.institution?.name ?? "",
              style: getBreadCrumbStyle(context)?.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
      if (userRepository.userRole != UserRole.HEALTHCARE_PROFESSIONAL)
        BreadCrumbItem(
          content: SelectableText(
            state is FetchedPatientsState
                ? (state.users.healthcareProfessional?.lastName ?? "") + " " + (state.users.healthcareProfessional?.firstName ?? "")
                : context.i18n.healthcareProfessional,
            style: getBreadCrumbStyle(context),
          ),
        ),
      if (userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL)
        BreadCrumbItem(
          content: Padding(
            padding: EdgeInsets.only(left: 10),
            child: SelectableText(
              headline,
              style: getBreadCrumbStyle(context),
            ),
          ),
        ),
    ];
  }

  String get traceablePageName => "Patient Overview Page";
}
