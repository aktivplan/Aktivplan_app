import 'package:apt_api/api.dart';
import 'package:aptapp/apt_scaffold.dart';
import 'package:aptapp/authentication/bloc/authentication.dart';
import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/drawer/admin_drawer.dart';
import 'package:aptapp/drawer/healthcare_professional_drawer.dart';
import 'package:aptapp/drawer/patient_drawer.dart';
import 'package:aptapp/drawer/super_admin_drawer.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/language_cubit.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AptBeamPage extends BeamPage {
  AptBeamPage({
    LocalKey? key,
    required Widget child,
    String title = "",
    String alternativeBackLocation = "",
    bool useMobileBackgroundColor = false,
    bool showBackButton = false,
    bool hideDrawer = false,
    required final BuildContext context,
  }) : super(
          key: key,
          title: title != "" ? "${context.i18n.appTitle} | $title" : context.i18n.appTitle,
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (showBackButton) {
                return ResponsiveBuilder(builder: (context, size) {
                  return Scaffold(
                    backgroundColor: size.isMobile && useMobileBackgroundColor ? mobileBackgroundColor : Colors.white,
                    appBar: AppBar(
                      elevation: 20,
                      leading: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (context.canBeamBack) {
                              context.beamBack();
                            } else if (alternativeBackLocation.isNotEmpty) {
                              context.beamToNamed(alternativeBackLocation);
                            }
                          }),
                    ),
                    body: child,
                  );
                });
              }
              final Widget? drawer = getDrawerForState(state, context);
              // no user logged in or no drawer
              if (drawer == null || hideDrawer) {
                return ResponsiveBuilder(builder: (context, size) {
                  return Scaffold(
                      backgroundColor: size.isMobile && useMobileBackgroundColor ? mobileBackgroundColor : Colors.white,
                      appBar: AppBar(
                        elevation: 20,
                        leading: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                          ),
                          onPressed: () => context.beamToNamed("/login"),
                        ),
                        actions: [
                          TextButton(
                            key: Key(KEY_BUTTON_CHANGE_LANGUAGE),
                            child: Text(Localizations.localeOf(context).languageCode == "de" ? "EN" : "DE"),
                            onPressed: () {
                              BlocProvider.of<LanguageCubit>(context).changeLanguage(context);
                            },
                          )
                        ],
                      ),
                      body: child);
                });
              }
              return AptScaffold(
                body: child,
                drawer: drawer,
                useMobileBackgroundColor: useMobileBackgroundColor,
              );
            },
          ),
        );

  static Widget getDrawerHeader(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 8, left: 8),
        child: IconButton(
          iconSize: 24,
          splashRadius: 25,
          key: Key(KEY_BUTTON_DRAWER_CLOSE),
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 20, right: 40, bottom: 20),
          child: Container(
            height: 100,
            child: FittedBox(
              child: Image.asset(
                "assets/images/logo.png",
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ]);
  }

  static Widget? getDrawerForState(AuthenticationState state, BuildContext context) {
    if (state is AuthenticationAdministrator) {
      return SuperAdminDrawer(drawerHeader: getDrawerHeader(context));
    } else if (state is AuthenticationInstitutionAdministrator) {
      return InstitutionAdminDrawer(drawerHeader: getDrawerHeader(context));
    } else if (state is AuthenticationHealthcareProfessional) {
      return HealthcareProfessionalDrawer(drawerHeader: getDrawerHeader(context));
    } else if (state is AuthenticationPatient) {
      return PatientDrawer(drawerHeader: getDrawerHeader(context));
    }

    final userRole = KiwiContainer().resolve<UserRepository>().userRole;
    if (userRole == UserRole.ADMINISTRATOR) {
      return SuperAdminDrawer(drawerHeader: getDrawerHeader(context));
    } else if (userRole == UserRole.INSTITUTION_ADMINISTRATOR) {
      return InstitutionAdminDrawer(drawerHeader: getDrawerHeader(context));
    } else if (userRole == UserRole.HEALTHCARE_PROFESSIONAL) {
      return HealthcareProfessionalDrawer(drawerHeader: getDrawerHeader(context));
    } else if (userRole == UserRole.PATIENT) {
      return PatientDrawer(drawerHeader: getDrawerHeader(context));
    }

    return null;
  }
}
