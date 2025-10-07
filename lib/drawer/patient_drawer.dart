import 'package:aptapp/activity/bloc/activity_bloc.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/mixins/logout_aware.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/utils/translation_helper.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PatientDrawer extends StatefulWidget {
  final Widget drawerHeader;
  PatientDrawer({Key? key, required this.drawerHeader}) : super(key: key);

  @override
  _PatientDrawerState createState() => _PatientDrawerState();
}

class _PatientDrawerState extends State<PatientDrawer> with LogoutAware {
  @override
  Widget build(BuildContext context) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return Drawer(
      child: ListView(
        children: [
          widget.drawerHeader,
          ListTile(
            key: Key(KEY_BUTTON_PROFILE),
            tileColor: RouterService.isActive(context, "/calendar/data") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.account_circle, color: primaryColor),
            title: Text(
              context.i18n.myProfile,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async => context.beamToNamed("/calendar/data", data: {'patient': userRepository.currentUser}),
          ),
          ListTile(
            tileColor: RouterService.isActive(context, "/calendar") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.date_range, color: primaryColor),
            title: Text(
              context.i18n.trainingPlan,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/calendar") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async => {
              context.beamToNamed(
                "/calendar",
                data: {"patient": userRepository.currentUser, 'id': userRepository.currentUser.id},
              )
            },
          ),
          ListTile(
            key: Key(KEY_BUTTON_EXPORT),
            tileColor: RouterService.isActive(context, "/export") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.import_export, color: primaryColor),
            title: Text(
              context.i18n.exportDocumentation,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/export") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
              context.beamToNamed("/export", data: {"id": userRepository.currentUser.id});
            },
          ),
          if (getTranslatedText(userRepository.currentInstitution?.url, context).isNotEmpty)
            ListTile(
              tileColor: Colors.transparent,
              leading: Icon(MdiIcons.hospitalBuilding, color: primaryColor),
              title: Text(
                userRepository.currentInstitution?.name ?? "",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: lightTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () {
                launchUrlString(getTranslatedText(userRepository.currentInstitution!.url, context));
              },
            ),
          ListTile(
            key: Key(KEY_BUTTON_VIDEOS),
            tileColor: RouterService.isActive(context, "/videos") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.play_circle_fill, color: primaryColor),
            title: Text(
              context.i18n.themeVideos,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/videos") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
              context.beamToNamed(
                "/videos",
                data: {"id": userRepository.currentUser.id},
              );
            },
          ),
          if (userRepository.currentInstitution?.enableSocialFeatures ?? false)
            ListTile(
              key: Key(KEY_BUTTON_CONTACTS),
              tileColor: RouterService.isActive(context, "/contacts") ? primarySwatch[50] : Colors.transparent,
              leading: Icon(Icons.supervisor_account_rounded, color: primaryColor),
              title: Text(
                context.i18n.myContacts,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: lightTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () async => context.beamToNamed("/contacts"),
            ),
          if (userRepository.hasExternalApps)
            ListTile(
              key: Key(KEY_BUTTON_ADDITIONAL_APPS),
              tileColor: RouterService.isActive(context, "/additional-apps") ? primarySwatch[50] : Colors.transparent,
              leading: Icon(MdiIcons.bookmarkBoxMultiple, color: primaryColor),
              title: Text(
                context.i18n.additionalApps,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: RouterService.isActive(context, "/additional-apps") ? Theme.of(context).primaryColor : lightTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () async {
                BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
                context.beamToNamed(
                  "/additional-apps",
                  data: {"id": userRepository.currentUser.id},
                );
              },
            ),
          ListTile(
            key: Key(KEY_BUTTON_HELP),
            tileColor: RouterService.isActive(context, "/help") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.help_outline, color: primaryColor),
            title: Text(
              context.i18n.help,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/help") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () async {
              BlocProvider.of<ActivityBloc>(context).add(ResetActivityEvent());
              context.beamToNamed("/help");
            },
          ),
          ListTile(
            key: Key(KEY_BUTTON_LEGAL_NOTICE),
            tileColor: RouterService.isActive(context, "/imprint") ? primarySwatch[50] : Colors.transparent,
            leading: Icon(Icons.contact_mail, color: primaryColor),
            title: Text(
              context.i18n.legalNoticeTermsAndConditionsMenu,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: RouterService.isActive(context, "/imprint") ? Theme.of(context).primaryColor : lightTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            onTap: () {
              context.beamToNamed("/imprint");
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
