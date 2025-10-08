// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/apt_app_bar.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/beamer/router_service.dart';
import 'package:aptapp/global_apt_cubit.dart';
import 'package:aptapp/global_apt_state.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/utils/constants.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AptScaffold extends StatefulWidget {
  final Widget body;
  final Widget? drawer;
  final Function(bool)? drawerStateChanged;
  final bool useMobileBackgroundColor;

  AptScaffold({Key? key, required this.body, this.drawer, this.drawerStateChanged, this.useMobileBackgroundColor = false}) : super(key: key);

  @override
  State<AptScaffold> createState() => _AptScaffoldState();
}

class _AptScaffoldState extends State<AptScaffold> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 1,
      duration: Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      curve: FlippedCurve(Curves.linear),
      parent: _controller!,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAptCubit, GlobalAptState>(
        bloc: APTApp.globalAptCubit,
        builder: (context, state) {
          double appBarHeight = kToolbarHeight;
          if (state is MobileAptAppBarState) {
            appBarHeight += state.height;
          }
          return ResponsiveBuilder(
            builder: (context, size) {
              return Scaffold(
                backgroundColor: size.isMobile && widget.useMobileBackgroundColor ? mobileBackgroundColor : Colors.white,
                appBar: AptAppBar(
                  size,
                  appBarState: state,
                  appBarSize: Size.fromHeight(appBarHeight),
                  onDrawerClick: () {
                    if (_key.currentState!.isDrawerOpen) {
                      Navigator.pop(context);
                    } else {
                      _key.currentState!.openDrawer();
                    }
                  },
                  drawerIconAnimation: _animation!,
                ),
                key: _key,
                drawer: doShowDrawer(size) ? widget.drawer : null,
                onDrawerChanged: (value) {
                  if (widget.drawerStateChanged != null) {
                    widget.drawerStateChanged!(value);
                  }
                  if (value) {
                    this._controller!.reverse();
                  } else {
                    this._controller!.forward();
                  }
                },
                body: widget.body,
                bottomNavigationBar: getBottomAppBar(context, size),
              );
            },
          );
        });
  }

  Widget? getBottomAppBar(BuildContext context, SizingInformation size) {
    if (userRepository.userRole == null || userRepository.userRole == UserRole.PATIENT) {
      return null;
    }
    return BottomAppBar(
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (size.isDesktop) SizedBox(width: 20),
                  TextButton(
                    key: Key(KEY_BUTTON_LEGAL_NOTICE),
                    child: Text(context.i18n.legalNoticeTermsAndConditionsMenu),
                    style: TextButton.styleFrom(
                        foregroundColor: RouterService.isDescendantActive(context, '/imprint') ? primaryColor : Colors.black,
                        textStyle: TextStyle(decoration: TextDecoration.underline)),
                    onPressed: () => {
                      context.beamToNamed('/imprint'),
                    },
                  ),
                ],
              ),
            ),
            if (size.screenSize.width > 780) Text("© ${context.i18n.legalNoticeCompanyName}"),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    key: Key(KEY_BUTTON_HELP),
                    child: Text(context.i18n.help),
                    style: TextButton.styleFrom(
                        foregroundColor: RouterService.isDescendantActive(context, '/help') ? primaryColor : Colors.black,
                        textStyle: TextStyle(decoration: TextDecoration.underline)),
                    onPressed: () => {
                      context.beamToNamed('/help'),
                    },
                  ),
                  if (size.isDesktop) SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
