// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;

class TipProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  List<TipsModel> _tips = [];
  bool _isLoading = false;

  List<TipsModel> get tips => _tips;
  bool get isLoading => _isLoading;

  Future<void> initializeData() async {
    if(_tips.isEmpty) {
      _isLoading = true;
    }
    notifyListeners();

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/tips/patient/user/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _tips = res.map<TipsModel>((json) => TipsModel.fromJson(json)).toList();
      } else {
        _tips = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _tips = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}