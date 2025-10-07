import 'package:apt_api/api.dart';
import 'package:aptapp/global_apt_state.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/mixins/logout_aware.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:aptapp/widget/message_button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AptAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SizingInformation size;
  final Function() onDrawerClick;
  final Animation<double> drawerIconAnimation;
  final Size appBarSize;
  final GlobalAptState appBarState;

  AptAppBar(this.size,
      {required this.appBarState,
      required this.onDrawerClick,
      required this.drawerIconAnimation,
      this.appBarSize = const Size.fromHeight(kToolbarHeight)});

  @override
  Size get preferredSize => appBarSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        Widget languageSwitchButton = TextButton(
          key: Key(KEY_BUTTON_CHANGE_LANGUAGE),
          child: Text(Localizations.localeOf(context).languageCode == "de" ? "EN" : "DE"),
          onPressed: () {
            BlocProvider.of<LanguageCubit>(context).changeLanguage(context);
          },
        );
        if (!(state is AuthenticationLoggedInState)) {
          return _LoggedOutAppBar(size: size, languageSwitchButton: languageSwitchButton);
        } else {
          if (!doShowDrawer(size)) {
            return _DesktopAppBar(languageSwitchButton: languageSwitchButton);
          }

          return _MobileAppBar(
            onDrawerClick: onDrawerClick,
            drawerIconAnimation: drawerIconAnimation,
            appBarSize: appBarSize,
            titleWidget: appBarState is MobileAptAppBarState ? (appBarState as MobileAptAppBarState).titleWidget : null,
            appContentWidget: appBarState is MobileAptAppBarState ? (appBarState as MobileAptAppBarState).appContentWidget : null,
          );
        }
      },
    );
  }
}

class _LoggedOutAppBar extends StatelessWidget {
  final SizingInformation size;
  final Widget languageSwitchButton;
  const _LoggedOutAppBar({Key? key, required this.size, required this.languageSwitchButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [languageSwitchButton],
    );
  }
}

class _DesktopAppBar extends StatefulWidget {
  final Widget languageSwitchButton;
  const _DesktopAppBar({Key? key, required this.languageSwitchButton}) : super(key: key);

  @override
  State<_DesktopAppBar> createState() => _DesktopAppBarState();
}

class _DesktopAppBarState extends State<_DesktopAppBar> with LogoutAware {
  @override
  Widget build(BuildContext context) {
    final userRepository = KiwiContainer().resolve<UserRepository>();
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: FittedBox(
          child: Image.asset(
            "assets/images/logo-right.png",
          ),
          fit: BoxFit.contain,
        ),
      ),
      leadingWidth: 168,
      centerTitle: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (userRepository.userRole == UserRole.ADMINISTRATOR || userRepository.userRole == UserRole.INSTITUTION_ADMINISTRATOR)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor:
                        RouterService.isDescendantActive(context, '/institutions') || RouterService.isDescendantActive(context, '/professionals')
                            ? primaryColor
                            : Colors.black),
                onPressed: () {
                  if (userRepository.userRole == UserRole.ADMINISTRATOR)
                    context.beamToNamed('/institutions');
                  else {
                    context.beamToNamed('/professionals');
                  }
                },
                child: Text(context.i18n.institutionOverview),
              ),
            ),
          if (userRepository.userRole == UserRole.HEALTHCARE_PROFESSIONAL)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor:
                        RouterService.isDescendantActive(context, '/patients') || RouterService.isDescendantActive(context, '/professionals')
                            ? primaryColor
                            : Colors.black),
                onPressed: () {
                  context.beamToNamed('/patients');
                },
                child: Text(context.i18n.patientOverview),
              ),
            ),
          if (userRepository.userRole != UserRole.PATIENT && userRepository.userRole != UserRole.ADMINISTRATOR)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                key: Key(KEY_BUTTON_MESSAGE_HISTORY),
                style: TextButton.styleFrom(
                    foregroundColor: RouterService.isDescendantActive(context, '/message-history') ? primaryColor : Colors.black),
                onPressed: () {
                  context.beamToNamed('/message-history');
                },
                child: Text(context.i18n.messages),
              ),
            ),
          if (userRepository.userRole != UserRole.PATIENT)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                key: Key(KEY_BUTTON_ACTIVITIES),
                style: TextButton.styleFrom(foregroundColor: RouterService.isDescendantActive(context, '/training') ? primaryColor : Colors.black),
                onPressed: () {
                  context.beamToNamed('/training');
                },
                child: Text(context.i18n.activities),
              ),
            ),
          if (userRepository.userRole != UserRole.PATIENT)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                key: Key(KEY_BUTTON_MESSAGES),
                style: TextButton.styleFrom(foregroundColor: RouterService.isDescendantActive(context, '/messages') ? primaryColor : Colors.black),
                onPressed: () {
                  context.beamToNamed('/messages');
                },
                child: Text(context.i18n.tipsAndInfos),
              ),
            ),
          if (userRepository.userRole != UserRole.PATIENT)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                key: Key(KEY_BUTTON_THEME_VIDEOS),
                style: TextButton.styleFrom(
                    foregroundColor: RouterService.isDescendantActive(context, '/video-templates') ? primaryColor : Colors.black),
                onPressed: () {
                  context.beamToNamed('/video-templates');
                },
                child: Text(context.i18n.themeVideos),
              ),
            ),
          if (userRepository.userRole != UserRole.PATIENT)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                key: Key(KEY_BUTTON_ADDITIONAL_APPS),
                style:
                    TextButton.styleFrom(foregroundColor: RouterService.isDescendantActive(context, '/external-apps') ? primaryColor : Colors.black),
                onPressed: () {
                  context.beamToNamed('/external-apps');
                },
                child: Text(context.i18n.additionalApps),
              ),
            ),
        ],
      ),
      actions: [
        widget.languageSwitchButton,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
            label: userRepository.userRole == UserRole.ADMINISTRATOR
                ? const Text("Admin")
                : Text("${userRepository.currentUser.firstName} ${userRepository.currentUser.lastName}"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextButton.icon(
            key: Key(KEY_BUTTON_LOGOUT),
            onPressed: () async => await this.logout(),
            icon: const Icon(Icons.logout),
            label: Text(context.i18n.logout),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

class _MobileAppBar extends StatefulWidget {
  final Function() onDrawerClick;
  final Animation<double> drawerIconAnimation;
  final Widget? titleWidget;
  final Widget? appContentWidget;
  final Size appBarSize;
  _MobileAppBar(
      {Key? key, required this.onDrawerClick, required this.drawerIconAnimation, this.titleWidget, this.appContentWidget, required this.appBarSize})
      : super(key: key);

  @override
  __MobileAppBarState createState() => __MobileAppBarState();
}

class __MobileAppBarState extends State<_MobileAppBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: kToolbarHeight,
            leading: IconButton(
              splashRadius: 25,
              key: Key(KEY_BUTTON_DRAWER),
              onPressed: () {
                this.widget.onDrawerClick();
              },
              icon: AnimatedIcon(
                progress: widget.drawerIconAnimation,
                color: Colors.black,
                icon: AnimatedIcons.close_menu,
              ),
            ),
            title: widget.titleWidget,
            centerTitle: true,
            actions: userRepository.userRole == UserRole.PATIENT ? [MessageButton()] : [],
          ),
        ),
        if (widget.appContentWidget != null) PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: widget.appContentWidget!)
      ],
    );
  }
}
