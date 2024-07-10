import 'package:beauty_wider/Core/app_imports.dart';

class LocalLanguageProvider with ChangeNotifier {
  Locale _localLanguage = const Locale('en');

  Locale get localLanguage => _localLanguage;

  LocalLanguageProvider() {
    _loadLocalLanguage();
  }

  Future<void> _loadLocalLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String languageCode = prefs.getString('languageCode') ?? 'en';
      _localLanguage = Locale(languageCode);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale value) async {
    _localLanguage = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', value.languageCode);
    notifyListeners();
  }
}