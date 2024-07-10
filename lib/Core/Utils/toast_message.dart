import 'package:beauty_wider/Core/app_imports.dart';

void showToastMessage({String? message, BuildContext? context}) {
  Fluttertoast.showToast(
    msg: message!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: WColors.primary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}