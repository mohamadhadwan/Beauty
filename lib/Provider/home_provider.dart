// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  String _userName = '';
  String _nextAppointment = '';
  bool _isLoading = false;
  List<SliderModel> _sliders = [];

  String get userName => _userName;
  String get nextAppointment => _nextAppointment;
  List<SliderModel> get sliders => _sliders;
  bool get isLoading => _isLoading;

  HomeProvider();

  void initializeData(BuildContext context) {
    fetchSliders();
    Provider.of<OurServiceProvider>(context, listen: false).initializeData();
    Provider.of<TipProvider>(context, listen: false).initializeData();
    getUserName();
    fetchNextAppointment();
  }

  Future<String> getUserName() async {
    final String firstName = await DatabaseProvider().getUserFirstName();
    final String lastName = await DatabaseProvider().getUserLastName();

    return _userName = '$firstName $lastName'.trim();
  }

  Future<void> fetchSliders() async {
    if(_sliders.isEmpty) {
      _isLoading = true;
    }
    notifyListeners();

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/sliders/inApp/userId/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _sliders = res.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
      } else {
        _sliders = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _sliders = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextAppointment() async {
    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/appointments/patient/profiles/next/user/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _nextAppointment = res['start'] ?? '';
      } else {
        _nextAppointment = '';
      }

      notifyListeners();
    } catch (e) {
      _nextAppointment = '';
      notifyListeners();
    }
  }

  List<SliderModel> getSlidersOfTypeService() {
    return _sliders.where((slider) => slider.type == 'service').toList();
  }

}