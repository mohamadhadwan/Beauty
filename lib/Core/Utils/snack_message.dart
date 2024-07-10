import 'package:beauty_wider/Core/app_imports.dart';

void showSnackMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: const TextStyle(color: white),
      ),
      backgroundColor: WColors.primary));
}
