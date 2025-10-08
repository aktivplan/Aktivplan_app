// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:apt_api/api.dart';
import 'package:aptapp/beamer/guards.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AptLayout extends StatelessWidget {
  final List<BreadCrumbItem> breadCrumb;
  final bool border;
  final bool fixedHeight;
  final bool halfHeight;
  final double spacing;
  final Widget? addButton;
  final List<Widget> children;
  final Widget? subtitle;
  final Widget? outsideWidget;

  const AptLayout(
      {Key? key,
      required this.breadCrumb,
      this.addButton,
      required this.children,
      this.border = true,
      this.fixedHeight = true,
      this.halfHeight = false,
      this.subtitle,
      this.outsideWidget,
      this.spacing = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final ScrollController _scrollController = ScrollController();
    final ScrollController _innerScrollController = ScrollController();
    if (addButton != null) {
      _innerScrollController.addListener(() {
        if (_innerScrollController.offset >= _innerScrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        } else if (_innerScrollController.offset <= _innerScrollController.position.minScrollExtent) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        }
      });
    }
    return ResponsiveBuilder(
      builder: (context, size) {
        double paddingTop = size.isDesktop
            ? height * 0.05
            : size.isTablet
                ? height * 0.01
                : height * 0.02;
        double paddingHorizontal = size.isDesktop
            ? width * 0.05
            : size.isTablet
                ? width * 0.01
                : width * 0.02;
        double containerHeight = size.isTablet
            ? height * 0.6
            : size.isMobile
                ? height * 0.75
                : height * 0.65;
        // subtract height of fixed footer
        if (userRepository.userRole != UserRole.PATIENT) {
          containerHeight -= 50;
        }
        if (halfHeight) {
          containerHeight /= 2;
        }
        return Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: paddingTop, left: paddingHorizontal, right: paddingHorizontal, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (breadCrumb.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BreadCrumb(
                          items: breadCrumb,
                          divider: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    if (subtitle != null) subtitle!,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Stack(
                        // alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: Container(
                              height: fixedHeight ? containerHeight : null,
                              decoration: border
                                  ? BoxDecoration(
                                      border: Border.all(
                                        color: datatableBorderColor,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(6)))
                                  : null,
                              child: SingleChildScrollView(
                                key: Key(KEY_LAYOUT_SCROLL_VIEW),
                                controller: _innerScrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [...this.children, if (!fixedHeight) SizedBox(height: 20), if (spacing > 0) SizedBox(height: spacing)],
                                ),
                              ),
                            ),
                          ),
                          if (addButton != null) Positioned(bottom: 0, left: 0, right: 0, child: Center(child: addButton)),
                        ],
                      ),
                    ),
                    if (outsideWidget != null) outsideWidget!,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
