import 'package:beauty_wider/Core/app_imports.dart';
import 'package:flutter/cupertino.dart';

class PageNavigator {
  PageNavigator({this.ctx});
  BuildContext? ctx;

  Future nextPage({Widget? page}) {
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: ((context) => page!)));
  }

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, MaterialPageRoute(builder: (context) => page!), (route) => false);
  }
}