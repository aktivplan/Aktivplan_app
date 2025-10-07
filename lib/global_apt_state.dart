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
