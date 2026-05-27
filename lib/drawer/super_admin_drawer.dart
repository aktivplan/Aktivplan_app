import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/institution/bloc/institution_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/mixins/logout_aware.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SuperAdminDrawer extends StatefulWidget {
  final Widget drawerHeader;
  SuperAdminDrawer({Key? key, required this.drawerHeader}) : super(key: key);

  @override
  _SuperAdminDrawerState createState() => _SuperAdminDrawerState();
}

class _SuperAdminDrawerState extends State<SuperAdminDrawer> with LogoutAware {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          widget.drawerHeader,
          ListTile(
              tileColor: RouterService.isDescendantActive(context, "/institutions") ? primarySwatch[50] : Colors.transparent,
              leading: Icon(MdiIcons.hospitalBuilding, color: primaryColor),
              title: Text(
                context.i18n.institutionOverview,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: RouterService.isDescendantActive(context, "/institutions") ? Theme.of(context).primaryColor : lightTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () async {
                BlocProvider.of<InstitutionBloc>(context).add(ResetInstitutionEvent());
                context.beamToNamed('/institutions');
              }),
          ListTile(
            key: Key(KEY_BUTTON_ACTIVITIES),
            tileColor: RouterService.isDescendantActive(context, "/training") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.accessibility, color: primaryColor),
            title: Text(
              context.i18n.activities,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isDescendantActive(context, "/training") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async => context.beamToNamed('/training'),
          ),
          ListTile(
            key: Key(KEY_BUTTON_MESSAGES),
            tileColor: RouterService.isActive(context, "/messages") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.message, color: primaryColor),
            title: Text(
              context.i18n.tipsAndInfos,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/messages") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              context.beamToNamed('/messages');
            },
          ),
          ListTile(
            key: Key(KEY_BUTTON_THEME_VIDEOS),
            tileColor: RouterService.isActive(context, "/video-templates") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.play_circle_fill, color: primaryColor),
            title: Text(
              context.i18n.themeVideos,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/video-templates") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              context.beamToNamed('/video-templates');
            },
          ),
          ListTile(
            key: Key(KEY_BUTTON_ADDITIONAL_APPS),
            tileColor: RouterService.isActive(context, "/external-apps") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(MdiIcons.bookmarkBoxMultiple, color: primaryColor),
            title: Text(
              context.i18n.additionalApps,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/external-apps") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              context.beamToNamed('/external-apps');
            },
          ),
          ListTile(
            key: Key(KEY_BUTTON_CHANGE_LANGUAGE),
            tileColor: Colors.transparent,
            leading: Icon(Icons.language, color: primaryColor),
            title: Text(
              context.i18n.switchLanguage,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () => BlocProvider.of<LanguageCubit>(context).changeLanguage(context),
          ),
          ListTile(
            key: Key(KEY_BUTTON_LOGOUT),
            tileColor: Colors.transparent,
            leading: Icon(Icons.exit_to_app, color: primaryColor),
            title: Text(
              context.i18n.logout,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async => await this.logout(),
          ),
        ],
      ),
    );
  }
}
