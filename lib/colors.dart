import 'package:flutter/material.dart';

Map<int, Color> primary = {
  50: Color(0xFFE1EFEF),
  100: Color(0xFFB5D7D8),
  200: Color(0xFF84BDBE),
  300: Color(0xFF53A3A4),
  400: Color(0xFF2E8F91),
  500: Color(0xFF097B7D),
  600: Color(0xFF087375),
  700: Color(0xFF06686A),
  800: Color(0xFF055E60),
  900: Color(0xFF024B4D),
};

Color calenderHeaderColor = const Color(0xFF1F6C6D);

MaterialColor primarySwatch = MaterialColor(0xFF097B7D, primary);

Map<int, Color> secondary = {
  50: Color(0xFFC8FFF4),
  100: Color(0xFF70EFDE),
  200: Color(0xFF03DAC5),
  300: Color(0xFF00C4B4),
  400: Color(0xFF00B3A6),
  500: Color(0xFF01A299),
  600: Color(0xFF019592),
  700: Color(0xFF018786),
  800: Color(0xFF017374),
  900: Color(0xFF005457),
};
MaterialColor secondaryColor = MaterialColor(0xFF5600E8, secondary);
//MaterialColor primarySwatch = MaterialColor(0xFF5600E8, secondary);

//Color primaryColor = Color(0xFF5600E8);
const Color primaryColor = Color(0xFF097B7D);
const Color accentColor = Color(0xFF00C4B4);
const Color errorColor = Color(0xFFB00020);
const Color mobileBackgroundColor = Color(0xffe6eeef);

const Color datatableBorderColor = const Color(0xFFE0E0E0);
const Color infoIconColor = Color(0xFF979797);
const Color lightTextColor = Colors.black54;
Color selectedDayColor = Color(0xFF018786).withOpacity(0.2);
const Color plannedActivityColor = Color(0xFF15BAC0);
const Color plannedTaskColor = Color(0xFF304FA1);
const Color extraActivityColor = Color(0xFF90617F);
const Color goalColor = Color(0xFFF8B154);

Map<int, Color> prime = {
  50: Color(0xFFF2E7FE),
  100: Color(0xFFDBB2FF),
  200: Color(0xFFBB86FC),
  300: Color(0xFF985EFF),
  400: Color(0xFF7F39FB),
  500: Color(0xFF6200EE),
  600: Color(0xFF5600E8),
  700: Color(0xFF3700B3),
  800: Color(0xFF30009C),
  900: Color(0xFF23036A),
};
Map<int, Color> second = {
  50: Color(0xFFC8FFF4),
  100: Color(0xFF70EFDE),
  200: Color(0xFF03DAC5),
  300: Color(0xFF00C4B4),
  400: Color(0xFF00B3A6),
  500: Color(0xFF01A299),
  600: Color(0xFF019592),
  700: Color(0xFF018786),
  800: Color(0xFF017374),
  900: Color(0xFF005457),
};

const color = Color(0xFF206D6C);
// #

//SLIDER COLORS
MaterialColor baseSwatch = MaterialColor(0xFF5600E8, prime);
MaterialColor baseSecond = MaterialColor(0xFF5600E8, second);
Color veryEasy = baseSecond[200]!;
Color easy = baseSwatch[600]!;
Color medium = Color(0xFF31D53C);
Color hardMedium = Color(0xFFFDCA1C);
Color hard = Color(0xFFFA8C1E);
Color harder = Color(0xFFFA5F1E);
Color extrem = Color(0xFFB00020);

Color trafficLight1 = Color(0xFFB00020);
Color trafficLight1Inactive = Color(0x99B00020);
Color trafficLight2 = Color(0xFFF8B154);
Color trafficLight3 = Color(0xFF097B7D);
