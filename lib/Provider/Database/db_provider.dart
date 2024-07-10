import 'package:beauty_wider/Core/app_imports.dart';
import 'package:beauty_wider/Core/utils/routers.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';

  String _firebaseToken = '';

  String _userId = '';

  String _otp = '';

  String _userFirstName = '';

  String _userLastName = '';

  String _userPhoneNumber = '';

  String _userCountryCode = '';

  bool _isLoggedIn = false;

  String get token => _token;

  String get firebaseToken => _firebaseToken;

  String get userId => _userId;

  String get otp => _otp;

  String get userFirstName => _userFirstName;

  String get userLastName => _userLastName;

  String get userPhoneNumber => _userPhoneNumber;

  String get userCountryCode => _userCountryCode;

  bool get isLoggedIn => _isLoggedIn;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveFirebaseToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('firebaseToken', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('userId', id);
  }

  void saveOtp(String otp) async {
    SharedPreferences value = await _pref;

    value.setString('otp', otp);
  }

  void saveUserFirstName(String firstName) async {
    SharedPreferences value = await _pref;

    value.setString('userFirstName', firstName);
  }

  void saveUserLastName(String lastName) async {
    SharedPreferences value = await _pref;

    value.setString('userLastName', lastName);
  }

  void saveUserPhoneNumber(String number) async {
    SharedPreferences value = await _pref;

    value.setString('userPhoneNumber', number);
  }

  void saveUserCountryCode(String countryCode) async {
    SharedPreferences value = await _pref;

    value.setString('userCountryCode', countryCode);
  }

  void saveIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences value = await _pref;

    value.setBool('isLoggedIn', isLoggedIn);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getFirebaseToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('firebaseToken')) {
      String data = value.getString('firebaseToken')!;
      _firebaseToken = data;
      notifyListeners();
      return data;
    } else {
      _firebaseToken = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userId')) {
      String data = value.getString('userId')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getOtp() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('otp')) {
      String data = value.getString('otp')!;
      _otp = data;
      notifyListeners();
      return data;
    } else {
      _otp = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserFirstName() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userFirstName')) {
      String data = value.getString('userFirstName')!;
      _userFirstName = data;
      notifyListeners();
      return data;
    } else {
      _userFirstName = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserLastName() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userLastName')) {
      String data = value.getString('userLastName')!;
      _userLastName = data;
      notifyListeners();
      return data;
    } else {
      _userLastName = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserPhoneNumber() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userPhoneNumber')) {
      String data = value.getString('userPhoneNumber')!;
      _userPhoneNumber = data;
      notifyListeners();
      return data;
    } else {
      _userPhoneNumber = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserCountryCode() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userCountryCode')) {
      String data = value.getString('userCountryCode')!;
      _userCountryCode = data;
      notifyListeners();
      return data;
    } else {
      _userCountryCode = '';
      notifyListeners();
      return '';
    }
  }

  Future<bool> getIsLoggedIn() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isLoggedIn')) {
      bool data = value.getBool('isLoggedIn')!;
      _isLoggedIn = data;
      notifyListeners();
      return data;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  void logOut() async {
    final SharedPreferences value = await _pref;
    value.clear();
  }
}
