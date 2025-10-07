import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/exercises/bloc/exercises_bloc.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/mixins/logout_aware.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InstitutionAdminDrawer extends StatefulWidget {
  final Widget drawerHeader;
  InstitutionAdminDrawer({Key? key, required this.drawerHeader}) : super(key: key);

  @override
  _InstitutionAdminDrawerState createState() => _InstitutionAdminDrawerState();
}

class _InstitutionAdminDrawerState extends State<InstitutionAdminDrawer> with LogoutAware {
  @override
  Widget build(BuildContext context) {
    final userRepository = KiwiContainer().resolve<UserRepository>();

    return Drawer(
      child: ListView(
        children: [
          widget.drawerHeader,
          ListTile(
            tileColor: RouterService.isActive(context, "/professionals") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(MdiIcons.hospitalBuilding, color: primaryColor),
            title: Text(
              context.i18n.institutionOverview,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/professionals") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async => context.beamToNamed('/professionals', data: {'institutionId': userRepository.currentUser.institutionId}),
          ),
          ListTile(
              key: Key(KEY_BUTTON_MESSAGE_HISTORY),
              tileColor: RouterService.isDescendantActive(context, "/message-history") ? primarySwatch[50] : Colors.transparent,
              leading: Icon(Icons.message, color: primaryColor),
              title: Text(
                context.i18n.messages,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: RouterService.isDescendantActive(context, "/message-history") ? Theme.of(context).primaryColor : lightTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () async {
                BlocProvider.of<ExerciseBloc>(context).add(ResetExerciseBlocEvent());
                context.beamToNamed('/message-history');
              }),
          ListTile(
            key: Key(KEY_BUTTON_ACTIVITIES),
            tileColor: RouterService.isActive(context, "/training") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.accessibility, color: primaryColor),
            title: Text(
              context.i18n.activities,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/training") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              BlocProvider.of<ExerciseBloc>(context).add(ResetExerciseBlocEvent());
              context.beamToNamed('/training');
            },
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
