import 'package:beauty_wider/core/app_imports.dart';

class WTextFromFieldTheme {
  WTextFromFieldTheme._();

  static InputDecorationTheme lightTextTheme = InputDecorationTheme(
    errorMaxLines: 1,
    contentPadding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 32.h),
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14.fSize, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14.fSize, color: WColors.primary, fontWeight: FontWeight.w300),
    errorStyle: const TextStyle().copyWith(fontSize: 12.fSize, color: Colors.black),
    border: const OutlineInputBorder().copyWith(
        borderSide: BorderSide.none
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderSide: BorderSide.none
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderSide: BorderSide.none
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderSide: BorderSide.none
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderSide: BorderSide.none
    ),
  );

  static InputDecorationTheme darkTextTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14.0, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14.0, color: Colors.white),
    errorStyle: const TextStyle().copyWith(fontSize: 14.0, color: Colors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey)
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey)
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.white)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.orange)
    ),
  );


}