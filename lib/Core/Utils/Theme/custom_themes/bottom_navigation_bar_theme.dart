import 'package:beauty_wider/Core/app_imports.dart';
import 'package:flutter/material.dart';

class WBottomNavigationBarTheme {
  WBottomNavigationBarTheme._();

  static const lightBottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: WColors.primary,
    unselectedIconTheme: IconThemeData(color: WColors.secondary2),
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
  );

  static const darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: WColors.primary,
    unselectedIconTheme: IconThemeData(color: WColors.secondary2),
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
  );
}