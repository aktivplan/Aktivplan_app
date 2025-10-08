// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

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
