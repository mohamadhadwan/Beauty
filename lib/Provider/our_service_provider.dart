// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;

class OurServiceProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  bool _isLoading = false;
  List<ServiceModel> _services = [];
  int _selectedServiceIndex = 0;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  int get selectedServiceIndex => _selectedServiceIndex;

  void setSelectedService(int service){
    _selectedServiceIndex = service;
    notifyListeners();
  }

  Future<void> initializeData() async {
    if(_services.isEmpty) {
      _isLoading = true;
    }
    notifyListeners();

    try {
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/services";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _services = res.map<ServiceModel>((json) => ServiceModel.fromJson(json)).toList();
      } else {
        _services = [];
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _services = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}