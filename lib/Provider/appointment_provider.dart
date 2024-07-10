// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  List<AppointmentsModel> _upcomingAppointments = [];
  List<AppointmentsModel> _pastAppointments = [];
  bool _isLoading = false;
  String _appointmentId = '';

  List<AppointmentsModel> get upcomingAppointments => _upcomingAppointments;
  List<AppointmentsModel> get pastAppointments => _pastAppointments;
  bool get isLoading => _isLoading;
  String get appointmentId => _appointmentId;

  void setAppointmentId(String id) {
    _appointmentId = id;
    notifyListeners();
  }

  Future<void> fetchAppointmentsByType(String type) async {
    if(_upcomingAppointments.isEmpty && _pastAppointments.isEmpty){
      _isLoading = true;
      notifyListeners();
    }

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();

      String url = "$requestBaseUrl/api/appointments/patient/profiles/all/$type/user/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);

        List<AppointmentsModel> appointments = (res as List).map((item) => AppointmentsModel.fromJson(item)).toList();
        if (type == 'upcoming') {
          _upcomingAppointments = appointments;
        } else {
          _pastAppointments = appointments;
        }
      } else {
        _upcomingAppointments = [];
        _pastAppointments = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _upcomingAppointments = [];
      _pastAppointments = [];
      notifyListeners();
      rethrow;
    }
  }
}

