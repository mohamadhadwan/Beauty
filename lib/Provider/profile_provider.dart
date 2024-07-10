// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/core/app_imports.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  String _firstName = '';
  String _lastName = '';
  String _number = '';
  String _countryCode = '';
  String _email = '';
  String _birthdate = '';
  String _address = '';
  bool _isLoading = false;
  String _resMessage = '';

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get number => _number;
  String get countryCode => _countryCode;
  String get email => _email;
  String get birthdate => _birthdate;
  String get address => _address;
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<void> getUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/patients/user_id/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _firstName = res['first_name'] ?? '';
        _lastName = res['last_name'] ?? '';
        _number = res['unverified_number'] ?? '';
        _countryCode = res['unverified_country_code']?.toString() ?? '';
        _email = res['email'] ?? '';
        _address = res['address'] ?? '';
        _birthdate = res['birthdate'] != null ? calculateAge(res['birthdate']) : '';

        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void updateUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String birthdate,
    required String gender,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userId = await DatabaseProvider().getUserId();
    final String token = await DatabaseProvider().getToken();

    String url = "$requestBaseUrl/api/patients/user_id/$userId";

    final Map<String, String> body = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "birthdate": birthdate,
      "gender": gender
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

        PageNavigator(ctx: context).nextPageOnly(page: const MyProfileScreen());
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

  String calculateAge(String birthDateString) {
    DateTime birthDate = DateTime.tryParse(birthDateString) ?? DateTime.now();
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
}
