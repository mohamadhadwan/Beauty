// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void registerUser({
    required String userFirstName,
    required String userLastName,
    required String userCountryCode,
    required String userPhoneNumber,
    required String userPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/api/auth/register/patient";

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> body = {
      "first_name": userFirstName,
      "last_name": userLastName,
      "countryCode": userCountryCode,
      "number": userPhoneNumber,
      "password": userPassword
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final dynamic res = json.decode(req.body);

        _isLoading = false;
        // _resMessage = res['message'];
        notifyListeners();

        final otp = res['user']['otp'].toString();

        DatabaseProvider().saveOtp(otp);
        DatabaseProvider().saveUserCountryCode(userCountryCode);
        DatabaseProvider().saveUserPhoneNumber(userPhoneNumber);
        DatabaseProvider().saveUserFirstName(userFirstName);
        DatabaseProvider().saveUserLastName(userLastName);

        PageNavigator(ctx: context).nextPageOnly(page: const OtpScreen());
      } else {
        final dynamic res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  void loginUser({
    required String userCountryCode,
    required String userPhoneNumber,
    required String userPassword,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/api/auth/login";

    final Map<String, String> body = {
      "countryCode": userCountryCode,
      "number": userPhoneNumber,
      "password": userPassword
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final dynamic res = json.decode(req.body);

        _isLoading = false;
        // _resMessage = res['message'];
        notifyListeners();

        final String token = res['token'];
        final String userId = res['user']['id'].toString();
        final String userFirstName = res['user']['first_name'];
        final String userLastName = res['user']['last_name'];

        DatabaseProvider().saveIsLoggedIn(true);
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        DatabaseProvider().saveUserCountryCode(userCountryCode);
        DatabaseProvider().saveUserPhoneNumber(userPhoneNumber);
        DatabaseProvider().saveUserFirstName(userFirstName);
        DatabaseProvider().saveUserLastName(userLastName);

        // String? firebaseToken = await _firebaseMessaging.getToken();
        // DatabaseProvider().saveFirebaseToken(firebaseToken!);
        // saveFirebaseToken(firebaseToken);

        PageNavigator(ctx: context)
            .nextPageOnly(page: const HomeBottomNavBarScreen(index: 0));
      } else if (req.statusCode == 403) {
        final dynamic res = json.decode(req.body);
        final String otp = res['otp'].toString();

        _isLoading = false;
        notifyListeners();

        DatabaseProvider().saveOtp(otp);
        DatabaseProvider().saveUserCountryCode(userCountryCode);
        DatabaseProvider().saveUserPhoneNumber(userPhoneNumber);

        PageNavigator(ctx: context).nextPageOnly(page: const OtpScreen());
      } else {
        final dynamic res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  void saveFirebaseToken(String firebaseToken) async {
    String url = "$requestBaseUrl/api/notifications/token";

    final String userId = await DatabaseProvider().getUserId();

    final Map<String, String> body = {
      "user_id": userId,
      "token": firebaseToken
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void verifyOtp({
    required String otp,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userCountryCode =
        await DatabaseProvider().getUserCountryCode();
    final String userPhoneNumber =
        await DatabaseProvider().getUserPhoneNumber();

    String url = "$requestBaseUrl/api/auth/verify";
    int otpInt = int.parse(otp);
    final body = {
      "countryCode": userCountryCode,
      "number": userPhoneNumber,
      "otp": otpInt
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final dynamic res = json.decode(req.body);

        _isLoading = false;
        // _resMessage = res['message'];
        notifyListeners();

        final String token = res['token'];
        final String userId = res['user']['id'].toString();
        final String userFirstName = res['user']['first_name'];
        final String userLastName = res['user']['last_name'];

        DatabaseProvider().saveIsLoggedIn(true);
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        DatabaseProvider().saveUserCountryCode(userCountryCode);
        DatabaseProvider().saveUserPhoneNumber(userPhoneNumber);
        DatabaseProvider().saveUserFirstName(userFirstName);
        DatabaseProvider().saveUserLastName(userLastName);
        DatabaseProvider().saveUserLastName(userLastName);

        // String? firebaseToken = await _firebaseMessaging.getToken();
        // DatabaseProvider().saveFirebaseToken(firebaseToken!);
        // saveFirebaseToken(firebaseToken);

        PageNavigator(ctx: context)
            .nextPageOnly(page: const HomeBottomNavBarScreen(index: 0));
      } else {
        final dynamic res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  void resendOtp({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userCountryCode =
        await DatabaseProvider().getUserCountryCode();
    final String userPhoneNumber =
        await DatabaseProvider().getUserPhoneNumber();

    String url = "$requestBaseUrl/api/auth/resend_otp";

    final Map<String, String> body = {
      "countryCode": userCountryCode,
      "number": userPhoneNumber
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final dynamic res = json.decode(req.body);

        _isLoading = false;
        _resMessage = res['otp'].toString();
        notifyListeners();
      } else {
        final dynamic res = json.decode(req.body);
        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }

  void showOtp({
    required BuildContext context,
  }) async {
    final String otp = await DatabaseProvider().getOtp();
    showSnackMessage(message: otp, context: context);
    notifyListeners();
  }

  void showOtp1({
    required BuildContext context,
  }) async {
    showSnackMessage(message: _resMessage, context: context);
    _resMessage = "";
    notifyListeners();
  }

  void logoutUser({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userId = await DatabaseProvider().getUserId();
    final String token = await DatabaseProvider().getToken();
    final String firebaseToken = await DatabaseProvider().getFirebaseToken();

    String url = "$requestBaseUrl/api/auth/logout";

    final Map<String, String> body = {
      "user_id": userId,
      "token": firebaseToken
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        notifyListeners();

        DatabaseProvider().logOut();
        PageNavigator(ctx: context).nextPageOnly(page: const SignInScreen());
      } else {
        final dynamic res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  void changeAppLanguage({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userId = await DatabaseProvider().getUserId();
    final String token = await DatabaseProvider().getToken();
    bool isEnglish = LocalLanguageProvider().localLanguage.languageCode == "en";

    String url = "$requestBaseUrl/api/auth/update_language/$userId";

    final Map<String, String> body = {
      "current_language": isEnglish ? 'en' : 'ar',
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      http.Response req = await http.put(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        notifyListeners();

        final LocalLanguageProvider localLanguageProvider = Provider.of<LocalLanguageProvider>(context, listen: false);
        localLanguageProvider.setLocale(Locale(localLanguageProvider.localLanguage.languageCode == 'en' ? 'ar' : 'en'));

      } else {
        final dynamic res = json.decode(req.body);

        _resMessage = res['message'];

        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }
}
