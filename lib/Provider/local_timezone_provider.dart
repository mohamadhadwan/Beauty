import 'package:beauty_wider/core/app_imports.dart';

class TimezoneProvider with ChangeNotifier {
  String _currentTimeZone = 'UTC';

  String get currentTimeZone => _currentTimeZone;

  TimezoneProvider() {
    _loadTimeZone();
  }

  _loadTimeZone() async {
    _currentTimeZone = await FlutterTimezone.getLocalTimezone();
    notifyListeners();
  }
}