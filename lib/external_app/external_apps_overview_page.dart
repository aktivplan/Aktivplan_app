import 'package:apt_api/api.dart';
import 'package:aptapp/apt_layout.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/external_app/bloc/external_app_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/theme.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:aptapp/widget/rounded_icon_button.dart';
import 'package:aptapp/widget/get_snackbar.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:reorderables/reorderables.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExternalAppsOverviewPage extends StatefulWidget {
  ExternalAppsOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ExternalAppsOverviewPageState createState() => _ExternalAppsOverviewPageState();
}

class _ExternalAppsOverviewPageState extends State<ExternalAppsOverviewPage> with TraceablePageMixin {
  bool isAscending = true;
  int selectedColumn = 0;
  bool isHome = true;
  List<ExternalAppDTO> externalApps = [];
  ExternalAppBloc? externalAppBloc;

  goToExternalApp(ExternalAppDTO externalApp) {
    context.beamToNamed('/external-apps/${externalApp.id}', data: {"externalApp": externalApp});
  }

  addExternalApp() {
    context.beamToNamed('/external-apps/add', beamBackOnPop: true);
  }

  @override
  void initState() {
    super.initState();
    externalAppBloc = BlocProvider.of<ExternalAppBloc>(context);
    externalAppBloc!.add(FetchExternalAppsEvent());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (context, size) {
        double paddingHorizontal = size.isDesktop
            ? width * 0.05
            : size.isTablet
                ? width * 0.01
                : width * 0.02;
        double innerWidth = width - paddingHorizontal * 2;
        return BlocConsumer<ExternalAppBloc, ExternalAppState>(
          listenWhen: (previous, state) {
            return true;
          },
          listener: (context, state) {
            var snackBar;
            if (state is AddedExternalAppState) {
              snackBar = getSnackbar(context.i18n.addedApp, size.isMobile, context);
            } else if (state is UpdatedExternalAppState) {
              snackBar = getSnackbar(context.i18n.updatedApp, size.isMobile, context);
            } else if (state is DeletedExternalAppState) {
              snackBar = getSnackbar(context.i18n.deletedApp, size.isMobile, context);
            }
            if (snackBar != null) {
              snackBar.show(context);
              snackBar = null;
            }
          },
          builder: (context, state) {
            return AptLayout(
              key: Key(KEY_EXTERNAL_APP_OVERVIEW_SCROLL_VIEW),
              spacing: 15,
              addButton: RoundedIconButton(
                key: Key(KEY_BUTTON_ADD),
                title: context.i18n.addApp,
                callback: addExternalApp,
              ),
              breadCrumb: <BreadCrumbItem>[
                BreadCrumbItem(
                  content: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SelectableText(
                      context.i18n.additionalApps,
                      style: getBreadCrumbStyle(context),
                    ),
                  ),
                ),
              ],
              children: [
                Builder(
                  builder: (context) {
                    if (state is FetchedExternalAppsState || state is OrderedExternalAppsState) {
                      if (state is FetchedExternalAppsState) {
                        externalApps = state.externalApps;
                      }
                      if (externalApps.isNotEmpty)
                        return ReorderableTable(
                          needsLongPressDraggable: size.isMobile,
                          ignorePrimaryScrollController: true,
                          border: TableBorder(
                              bottom: BorderSide(color: datatableBorderColor), left: BorderSide.none, right: BorderSide.none, top: BorderSide.none),
                          borderColor: datatableBorderColor,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              var temp = externalApps[oldIndex];
                              externalApps[oldIndex] = externalApps[newIndex];
                              externalApps[newIndex] = temp;
                            });
                            externalAppBloc!.add(UpdateExternalAppsOrderingEvent(orderedIds: externalApps.map((e) => e.id!).toList()));
                          },
                          header: ReorderableTableRow(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            tableRowPadding(
                              child: Text(
                                context.i18n.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (!size.isMobile)
                              tableRowPadding(
                                child: Text(
                                  context.i18n.description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ]),
                          children: externalApps
                              .map(
                                (externalApp) => ReorderableTableRow(
                                  key: Key(externalApp.id.toString()),
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: innerWidth * (size.isMobile ? 0.95 : 0.6),
                                      child: tableRowPadding(
                                        child: Row(
                                          children: [
                                            Icon(Icons.menu),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                getTranslatedText(externalApp.title, context),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: 1.1),
                                              ),
                                            ),
                                            if (size.isMobile)
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => goToExternalApp(externalApp),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (!size.isMobile)
                                      Container(
                                        width: innerWidth * 0.35,
                                        child: tableRowPadding(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  getTranslatedText(externalApp.description, context),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                        letterSpacing: 1.1,
                                                      ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => goToExternalApp(externalApp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                      else
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height * 0.55,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SelectableText(
                                    context.i18n.noApps,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: lightTextColor,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
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

  String get traceablePageName => "External Apps Overview Page";
}
