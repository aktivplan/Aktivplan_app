import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/user/bloc/user_bloc.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/apt_data_column.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InstitutionOverviewPage extends StatefulWidget {
  InstitutionOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _InstitutionOverviewPageState createState() => _InstitutionOverviewPageState();
}

class _InstitutionOverviewPageState extends State<InstitutionOverviewPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  List<InstitutionDTO> institutions = List<InstitutionDTO>.empty();

  sortColumn(int columnIndex, bool ascending, bool numeric) {
    setState(() {
      isAscending = ascending;
      selectedColumn = columnIndex;
    });
    if (columnIndex == 1) {
      if (ascending) {
        institutions.sort((a, b) => (a.lastName ?? "").toLowerCase().compareTo((b.name ?? "").toLowerCase()));
      } else {
        institutions.sort((a, b) => (b.lastName ?? "").toLowerCase().compareTo((a.lastName ?? "").toLowerCase()));
      }
    } else {
      if (ascending) {
        institutions.sort((a, b) => (a.name ?? "").toLowerCase().compareTo((b.name ?? "").toLowerCase()));
      } else {
        institutions.sort((a, b) => (b.name ?? "").toLowerCase().compareTo((a.name ?? "").toLowerCase()));
      }
    }
  }

  goToInstitution(InstitutionDTO user) {
    BlocProvider.of<InstitutionBloc>(context).add(ResetInstitutionEvent());
    context.beamToNamed('/institutions/${user.id}/healthcare-professionals');
  }

  addUser() async {
    context.beamToNamed('/institutions/add', beamBackOnPop: true);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InstitutionBloc>(context)..add(FetchInstitutionsEvent());
    BlocProvider.of<UserBloc>(context)..add(ResetUserBlocEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (context, size) {
        return BlocConsumer<InstitutionBloc, InstitutionState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            var snackBar;
            if (state is AddedInstitutionState) {
              snackBar = getSnackbar(context.i18n.addedInstitution, size.isMobile, context);
            } else if (state is UpdatedInstitutionState) {
              snackBar = getSnackbar(context.i18n.updatedInstitution, size.isMobile, context);
            } else if (state is DeletedInstitutionState) {
              snackBar = getSnackbar(context.i18n.deletedInstitution, size.isMobile, context);
            } else if (state is InstitutionErrorState) {
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
          },
          builder: (context, state) {
            return AptLayout(
              key: Key(KEY_INSTITUTION_OVERVIEW_SCROLL_VIEW),
              addButton: RoundedIconButton(
                title: context.i18n.addInstitution,
                callback: addUser,
              ),
              breadCrumb: <BreadCrumbItem>[
                BreadCrumbItem(
                  content: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SelectableText(
                      context.i18n.institutionOverview,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
                ),
              ],
              children: [
                Builder(
                  builder: (context) {
                    if (state is FetchedInstitutionsState) {
                      institutions = state.institutions;
                      if (institutions.isNotEmpty)
                        return DataTable(
                          showCheckboxColumn: false,
                          showBottomBorder: true,
                          sortAscending: isAscending,
                          sortColumnIndex: selectedColumn,
                          // columnSpacing: 0,
                          // horizontalMargin: 0,
                          columns: [
                            AptDataColumn(
                              dataColoumnIndex: 0,
                              selectedColumnIndex: selectedColumn,
                              label: Text(
                                context.i18n.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onSort: (columnIndex, ascending) {
                                sortColumn(columnIndex, ascending, false);
                              },
                            ),
                            if (!size.isMobile)
                              AptDataColumn(
                                dataColoumnIndex: 1,
                                selectedColumnIndex: selectedColumn,
                                label: Text(
                                  context.i18n.administrator,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSort: (columnIndex, ascending) {
                                  sortColumn(columnIndex, ascending, false);
                                },
                              )
                          ],
                          rows: institutions
                              .map(
                                (institution) => DataRow(
                                  onSelectChanged: (selected) => goToInstitution(institution),
                                  cells: [
                                    DataCell(
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            institution.name!,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                          ),
                                          if (size.isMobile)
                                            IconButton(
                                              icon: Icon(Icons.arrow_forward_ios),
                                              onPressed: () => goToInstitution(institution),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (!size.isMobile)
                                      DataCell(
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              (institution.lastName ?? "") + " " + (institution.firstName ?? ""),
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    letterSpacing: 1.1,
                                                  ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.arrow_forward_ios),
                                              onPressed: () => goToInstitution(institution),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      else {
                        return Container(
                          height: height * 0.55,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SelectableText(
                                context.i18n.noInstitutions,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: lightTextColor,
                                    ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String get traceablePageName => "Institution Overview Page";
}
