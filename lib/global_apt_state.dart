// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class GlobalAptState extends Equatable {
  GlobalAptState();

  @override
  List<Object> get props => [];
}

class MobileAptAppBarState extends GlobalAptState {
  final Widget titleWidget;
  final Widget appContentWidget;
  final double height;

  MobileAptAppBarState(this.titleWidget, this.appContentWidget, this.height);
  @override
  List<Object> get props => [titleWidget, appContentWidget];
}

class NoInternetAptState extends GlobalAptState {}

class NeedUpdateAptState extends GlobalAptState {
  final String latestVersion;
  NeedUpdateAptState(this.latestVersion);
  @override
  List<Object> get props => [latestVersion];
}

class ClickedNotificationAptState extends GlobalAptState {}
