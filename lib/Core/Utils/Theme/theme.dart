import 'package:beauty_wider/Core/utils/constants/colors.dart';
import 'package:beauty_wider/Core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:beauty_wider/core/utils/theme/custom_themes/bottom_navigation_bar_theme.dart';
import 'package:flutter/material.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class WAppTheme {
  WAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'cairo',
      brightness: Brightness.light,
      primaryColor: WColors.primary,
      scaffoldBackgroundColor: Colors.white,
      textTheme: WTextTheme.lightTextTheme,
      elevatedButtonTheme: WElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: WAppBarTheme.lightAppBarTheme,
      // outlinedButtonTheme: ,
      inputDecorationTheme: WTextFromFieldTheme.lightTextTheme,
      bottomNavigationBarTheme:
          WBottomNavigationBarTheme.lightBottomNavigationBarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'cairo',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: WTextTheme.darkTextTheme,
      elevatedButtonTheme: WElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: WAppBarTheme.darkAppBarTheme,
      // outlinedButtonTheme: ,
      inputDecorationTheme: WTextFromFieldTheme.darkTextTheme,
      bottomNavigationBarTheme:
          WBottomNavigationBarTheme.darkBottomNavigationBarTheme);
}
