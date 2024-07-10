// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:beauty_wider/Model/my_history_model.dart';
import 'package:http/http.dart' as http;

class MyHistoryProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  List<MyHistoryModel> _history = [];
  bool _isLoading = false;

  List<MyHistoryModel> get history => _history;
  bool get isLoading => _isLoading;

  Future<void> initializeData() async {
    if(_history.isEmpty) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/patients/treatment_details/in_app/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        _history = res.map<MyHistoryModel>((json) => MyHistoryModel.fromJson(json)).toList();
      } else {
        _history = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _history = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}