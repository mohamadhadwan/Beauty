// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';

class WTextTheme {
  WTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 30.fSize, fontWeight: FontWeight.bold, color: WColors.primary),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.fSize, fontWeight: FontWeight.w600, color: WColors.primary),
    headlineSmall: const TextStyle().copyWith(fontSize: 20.fSize, fontWeight: FontWeight.w300, color: WColors.primary),

    titleLarge: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w600, color: WColors.primary),
    titleMedium: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w500, color: WColors.primary),
    titleSmall: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w400, color: WColors.primary),

    bodyLarge: const TextStyle().copyWith(fontSize: 18.fSize, fontWeight: FontWeight.w400, color: WColors.primary),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.fSize, fontWeight: FontWeight.normal, color: WColors.primary),
    bodySmall: const TextStyle().copyWith(fontSize: 12.fSize, fontWeight: FontWeight.w400, color: WColors.primary.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.fSize, fontWeight: FontWeight.normal, color: WColors.primary),
    labelMedium: const TextStyle().copyWith(fontSize: 12.fSize, fontWeight: FontWeight.normal, color: WColors.primary.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.fSize, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.fSize, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.fSize, fontWeight: FontWeight.w600, color: Colors.white),

    titleLarge: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w400, color: Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.fSize, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.fSize, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: const TextStyle().copyWith(fontSize: 12.fSize, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5)),
  );
}