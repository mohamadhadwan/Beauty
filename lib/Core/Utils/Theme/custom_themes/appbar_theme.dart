import 'package:beauty_wider/Core/app_imports.dart';
import 'package:flutter/material.dart';

class WAppBarTheme {
  WAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: WColors.primary, size: 24.adaptSize),
    actionsIconTheme: IconThemeData(color: WColors.primary, size: 24.adaptSize),
    titleTextStyle: TextStyle(fontSize: 18.fSize, fontWeight: FontWeight.normal, color: WColors.primary)
  );

  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)
  );
}