// Copyright LBI-DHP and/or licensed to LBI-DHP under one or more
// contributor license agreements (LBI-DHP: Ludwig Boltzmann Institute
// for Digital Health and Prevention -- A research institute of the
// Ludwig Boltzmann Gesellschaft, Österreichische Vereinigung zur
// Förderung der wissenschaftlichen Forschung).
// Licensed under the Apache 2.0 license with Commons Clause
// (see https://www.apache.org/licenses/LICENSE-2.0 and
// https://commonsclause.com/).

import 'package:aptapp/colors.dart';
import 'package:flutter/material.dart';

ThemeData getAptTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: Colors.white,
    hintColor: datatableBorderColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: infoIconColor),
    ),
    colorScheme: Theme.of(context).colorScheme.copyWith(error: errorColor, primary: primaryColor),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 10, iconTheme: IconThemeData(color: Colors.black, size: 24)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(),
    fontFamily: 'Roboto',
  );
}

TextTheme _buildTextTheme() {
  final base = ThemeData.light().textTheme;
  return TextTheme(
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: primarySwatch[800],
      height: 3,
      letterSpacing: 1.03,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelLarge: base.labelLarge?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 1.5,
    ),
  );
}

TextStyle? getBreadCrumbStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.03,
      );
}

ButtonStyle getElevatedButtonStyle(BuildContext context, {Color? backgroundColor}) {
  return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      minimumSize: const Size(64, 50));
}
