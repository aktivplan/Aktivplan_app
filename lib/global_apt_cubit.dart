import 'package:aptapp/global_apt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalAptCubit extends Cubit<GlobalAptState> {
  GlobalAptCubit() : super(GlobalAptState());

  void triggerNoInternet() {
    emit(NoInternetAptState());
  }

  void triggerNeedUpdate(String latestVersion) {
    emit(NeedUpdateAptState(latestVersion));
  }

  void setAppBarWidgets(Widget titleWidget, Widget appContentWidget, double height) {
    emit(MobileAptAppBarState(titleWidget, appContentWidget, height));
  }

  void reset() {
    emit(GlobalAptState());
  }

  void clickedNotification() {
    emit(ClickedNotificationAptState());
  }
}
