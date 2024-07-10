// ignore_for_file: depend_on_referenced_packages
import 'package:beauty_wider/Core/app_imports.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class BookAppointmentProvider with ChangeNotifier {
  final String requestBaseUrl = WAppUrl.baseUrl;

  String _resMessage = '';

  String get resMessage => _resMessage;

  List<ClinicBranchModel> _clinicBranches = [];
  int _selectedBranchIndex = 0;
  int _selectedTechnicianIndex = 0;
  int? _selectedTimeIndex;
  List<int>? _selectedOptionsIndex;

  String _selectedSkinType = 'Dry';
  String get selectedSkinType => _selectedSkinType;

  String _selectedSkinSensitivity = 'Normal';
  String get selectedSkinSensitivity => _selectedSkinSensitivity;

  String? _heightField;
  String? get heightField => _heightField;

  String? _weightField;
  String? get weightField => _weightField;

  DateTime _selectedDate = DateTime.now().toLocal();

  String _selectedTime = '';

  List<String> _availableTimeSlots = [];

  bool _isLoading = true;

  List<ClinicBranchModel> get clinicBranches => _clinicBranches;
  int get selectedBranchIndex => _selectedBranchIndex;

  int get selectedTechnicianIndex => _selectedTechnicianIndex;
  int? get selectedTimeIndex => _selectedTimeIndex;

  List<int>? get selectedOptionsIndex => _selectedOptionsIndex;

  bool _question1Status = true;
  bool get question1Status => _question1Status;

  String? _question1Field;
  String? get question1Field => _question1Field;

  bool _question2Status = true;
  bool get question2Status => _question2Status;

  String? _question2Field;
  String? get question2Field => _question2Field;

  bool _question3Status = true;
  bool get question3Status => _question3Status;

  String? _question3Field;
  String? get question3Field => _question3Field;

  bool _question4Status = true;
  bool get question4Status => _question4Status;

  String? _question4Field;
  String? get question4Field => _question4Field;

  bool _question5Status = true;
  bool get question5Status => _question5Status;

  bool _question6Status = true;
  bool get question6Status => _question6Status;

  String? _question6Field;
  String? get question6Field => _question6Field;

  bool _question7Status = true;
  bool get question7Status => _question7Status;

  String? _question7Field;
  String? get question7Field => _question7Field;

  bool _question8Status = true;
  bool get question8Status => _question8Status;

  String? _question8Field;
  String? get question8Field => _question8Field;

  DateTime get selectedDate => _selectedDate;

  String? get selectedTime => _selectedTime;

  bool get isLoading => _isLoading;

  String currentTimeZone = 'UTC';

  void loadTimeZone() async {
    currentTimeZone = await FlutterTimezone.getLocalTimezone();
    notifyListeners();
  }

  void selectBranch(int index) {
    _selectedBranchIndex = index;
    notifyListeners();
  }

  void selectTechnician(int index) {
    _selectedTechnicianIndex = index;
    notifyListeners();
  }

  void selectOptions(int index) {
    if (_selectedOptionsIndex == null) {
      _selectedOptionsIndex = [index];
    } else {
      if (_selectedOptionsIndex!.contains(index)) {
        _selectedOptionsIndex!.remove(index);
      } else {
        _selectedOptionsIndex!.add(index);
      }
    }
    notifyListeners();
  }

  void selectTime(int index) {
    _selectedTimeIndex = index;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setChosenHeight(String number) {
    _heightField = number;
    notifyListeners();
  }

  void setChosenWeight(String number) {
    _weightField = number;
    notifyListeners();
  }

  void setSelectedSkinType(String type) {
    _selectedSkinType = type;
    notifyListeners();
  }

  void setSelectedSkinSensitivity(String type) {
    _selectedSkinSensitivity = type;
    notifyListeners();
  }

  void setQuestion1Status(bool status) {
    _question1Status = status;
    notifyListeners();
  }

  void setQuestion1Field(String field) {
    _question1Field = field;
    notifyListeners();
  }

  void setQuestion2Status(bool status) {
    _question2Status = status;
    notifyListeners();
  }

  void setQuestion2Field(String field) {
    _question2Field = field;
    notifyListeners();
  }

  void setQuestion3Status(bool status) {
    _question3Status = status;
    notifyListeners();
  }

  void setQuestion3Field(String field) {
    _question3Field = field;
    notifyListeners();
  }

  void setQuestion4Status(bool status) {
    _question4Status = status;
    notifyListeners();
  }

  void setQuestion4Field(String field) {
    _question4Field = field;
    notifyListeners();
  }

  void setQuestion5Status(bool status) {
    _question5Status = status;
    notifyListeners();
  }

  void setQuestion6Status(bool status) {
    _question6Status = status;
    notifyListeners();
  }

  void setQuestion6Field(String field) {
    _question6Field = field;
    notifyListeners();
  }

  void setQuestion7Status(bool status) {
    _question7Status = status;
    notifyListeners();
  }

  void setQuestion7Field(String field) {
    _question7Field = field;
    notifyListeners();
  }

  void setQuestion8Status(bool status) {
    _question8Status = status;
    notifyListeners();
  }

  void setQuestion8Field(String field) {
    _question8Field = field;
    notifyListeners();
  }

  BookAppointmentProvider() {
    loadTimeZone();
    resetSelections();
  }

  void resetSelections() {
    _selectedBranchIndex = 0;
    _selectedTechnicianIndex = 0;
    _selectedOptionsIndex = [];
    _selectedTimeIndex = null;
    _selectedDate = DateTime.now();
    _selectedTime = '';
    _availableTimeSlots = [];
    _heightField = null;
    _weightField = null;
    _selectedSkinType = 'Dry';
    _selectedSkinSensitivity = 'Normal';
    _question1Status = true;
    _question2Status = true;
    _question3Status = true;
    _question4Status = true;
    _question5Status = true;
    _question6Status = true;
    _question7Status = true;
    _question8Status = true;
    _question1Field = null;
    _question2Field = null;
    _question3Field = null;
    _question4Field = null;

    _question6Field = null;
    _question7Field = null;
    _question8Field = null;

    notifyListeners();
  }

  Future<void> getBranches(int serviceId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final String userId = await DatabaseProvider().getUserId();
      final String token = await DatabaseProvider().getToken();
      String url =
          "$requestBaseUrl/api/appointments/availableTimes/serviceId/$serviceId/userId/$userId";

      final http.Response req = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200 || req.statusCode == 201) {
        dynamic res = jsonDecode(req.body);
        List<ClinicBranchModel> tempBranches = [];
        for (dynamic branchJson in res) {
          ClinicBranchModel branch = ClinicBranchModel.fromJson(branchJson);
          tempBranches.add(branch);
        }
        _clinicBranches = tempBranches;

        if (_clinicBranches[_selectedBranchIndex]
            .technicians[_selectedTechnicianIndex]
            .consultationCard
            .isNotEmpty) {
          ConsultationCard consultationCard =
              _clinicBranches[_selectedBranchIndex]
                  .technicians[_selectedTechnicianIndex]
                  .consultationCard[0];

          _heightField = consultationCard.height;
          _weightField = consultationCard.weight;

          _selectedSkinType = consultationCard.skinType;
          _selectedSkinSensitivity = consultationCard.sensitivity;

          _question1Status =
              !consultationCard.chronicMedicalConditions.isEmptyOrNull;
          _question1Field = _question1Status
              ? consultationCard.chronicMedicalConditions
              : null;

          _question2Status = !consultationCard.pacemaker.isEmptyOrNull;
          _question2Field =
              _question2Status ? consultationCard.pacemaker : null;

          _question3Status = !consultationCard.hormoneImbalances.isEmptyOrNull;
          _question3Field =
              _question3Status ? consultationCard.hormoneImbalances : null;

          _question4Status =
              !consultationCard.metalOrMedicalDevicesImplanted.isEmptyOrNull;
          _question4Field = _question4Status
              ? consultationCard.metalOrMedicalDevicesImplanted
              : null;

          _question5Status = consultationCard.thyroidProblem;

          _question6Status = !consultationCard.allergies.isEmptyOrNull;
          _question6Field =
              _question6Status ? consultationCard.allergies : null;

          _question7Status = !consultationCard.skinProblems.isEmptyOrNull;
          _question7Field =
              _question7Status ? consultationCard.skinProblems : null;

          _question8Status =
              !consultationCard.medicationsAndSupplements.isEmptyOrNull;
          _question8Field = _question8Status
              ? consultationCard.medicationsAndSupplements
              : null;
        }
      } else {
        _clinicBranches = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _clinicBranches = [];
      notifyListeners();
      rethrow;
    }
  }

  void createAppointment({
    required String remark,
    required int serviceId,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String userId = await DatabaseProvider().getUserId();
    final String token = await DatabaseProvider().getToken();

    String url =
        "$requestBaseUrl/api/appointments/createByPatient/userId/$userId";

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    DateFormat timeFormat = DateFormat("h:mm a");

    DateTime parsedTime = _selectedTime.isEmptyOrNull
        ? timeFormat.parse(_availableTimeSlots[0])
        : timeFormat.parse(_selectedTime);

    DateTime appointmentStart = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    ).toUtc();

    String startIsoString = appointmentStart.toIso8601String();

    int clinicBranchId = _clinicBranches[selectedBranchIndex].id;

    int technicianId = _clinicBranches[_selectedBranchIndex]
        .technicians[_selectedTechnicianIndex]
        .id;

    int duration = 30;

    String type = "treatment";

    dynamic question1 = _question1Field;
    dynamic question2 = _question2Field;
    dynamic question3 = !_question3Status ? null : _question3Field;
    dynamic question4 = !_question4Status ? null : _question4Field;

    dynamic question6 = !_question6Status ? null : _question6Field;
    dynamic question7 = !_question7Status ? null : _question7Field;
    dynamic question8 = !_question8Status ? null : _question8Field;

    final Map<String, Object?> body = {
      'clinic_branch_id': clinicBranchId,
      'service_id': serviceId,
      'type': type,
      'technician_id': technicianId,
      'start': startIsoString,
      'duration': duration,
      'option': selectedOptionsIndex,
      'notes': remark,
      'height': _heightField,
      'weight': _weightField,
      'skinType': _selectedSkinType,
      'sensitivity': _selectedSkinSensitivity,
      'chronicMedicalConditions': question1,
      'pacemaker': question2,
      'hormoneImbalances': question3,
      'metalOrMedicalDevicesImplanted': question4,
      'thyroidProblem': _question5Status,
      'allergies': question6,
      'skinProblems': question7,
      'medicationsAndSupplements': question8
    };

    print(body);
    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        notifyListeners();

        PageNavigator(ctx: context)
            .nextPageOnly(page: const HomeBottomNavBarScreen(index: 2));
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

  void addConsultationCard({
    required String appointmentId,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String token = await DatabaseProvider().getToken();

    String url = "$requestBaseUrl/api/appointments/card";

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    if (!_question1Status) {
      _question1Field = null;
    }

    if (!_question2Status) {
      _question2Field = null;
    }

    if (!_question3Status) {
      _question3Field = null;
    }

    if (!_question4Status) {
      _question4Field = null;
    }

    if (!_question6Status) {
      _question6Field = null;
    }

    if (!_question7Status) {
      _question7Field = null;
    }

    if (!_question8Status) {
      _question8Field = null;
    }

    String? question1 = !_question1Status ? null : _question1Field;
    String? question2 = !_question2Status ? null : _question2Field;
    String? question3 = !_question3Status ? null : _question3Field;
    String? question4 = !_question4Status ? null : _question4Field;

    String? question6 = !_question6Status ? null : _question6Field;
    String? question7 = !_question7Status ? null : _question7Field;
    String? question8 = !_question8Status ? null : _question8Field;

    final Map<String, Object?> body = {
      'appointment_id': appointmentId,
      'height': _heightField,
      'weight': _weightField,
      'skinType': _selectedSkinType,
      'sensitivity': _selectedSkinSensitivity,
      'chronicMedicalConditions': question1,
      'pacemaker': question2,
      'hormoneImbalances': question3,
      'metalOrMedicalDevicesImplanted': question4,
      'thyroidProblem': _question5Status,
      'allergies': question6,
      'skinProblems': question7,
      'medicationsAndSupplements': question8
    };

    try {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        notifyListeners();

        PageNavigator(ctx: context)
            .nextPageOnly(page: const HomeBottomNavBarScreen(index: 2));
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

  bool get hasAvailableStaff {
    ClinicBranchModel branch = clinicBranches[selectedBranchIndex];
    return branch.technicians.isNotEmpty;
  }

  bool isDayFullyBooked(
      TechnicianAppointments technicianAppointments, WorkHours workHours) {
    DateTime workStart = DateFormat('HH:mm:ss').parse(workHours.start);
    DateTime workEnd = DateFormat('HH:mm:ss').parse(workHours.end);

    int totalWorkMinutes = workEnd.difference(workStart).inMinutes;

    int totalBookedMinutes = 0;

    for (dynamic technicianAppointmentsDetails
        in technicianAppointments.technicianAppointmentsDetails) {
      DateTime technicianAppointmentsDetailsStart = DateFormat('HH:mm:ss')
          .parse(technicianAppointmentsDetails.start)
          .add(const Duration(hours: 2));
      DateTime technicianAppointmentsDetailsEnd = DateFormat('HH:mm:ss')
          .parse(technicianAppointmentsDetails.end)
          .add(const Duration(hours: 2));

      totalBookedMinutes += technicianAppointmentsDetailsEnd
          .difference(technicianAppointmentsDetailsStart)
          .inMinutes;
    }

    return totalBookedMinutes >= totalWorkMinutes;
  }

  bool isDayAvailable(DateTime day, BuildContext context) {
    if (!hasAvailableStaff) {
      return false;
    }

    String formattedDay = DateFormat('yyyy-MM-dd').format(day);
    String dayOfWeek = DateFormat('EEEE').format(day);
    List<String> availableTimeSlots = getTimeSlotsForDay(day, context);

    if (availableTimeSlots.isEmpty) {
      return false;
    }

    ClinicBranchModel selectedBranch = _clinicBranches[_selectedBranchIndex];
    Technician technician =
        selectedBranch.technicians[_selectedTechnicianIndex];

    if (!technician.workHours.containsKey(dayOfWeek)) {
      return false;
    }

    for (TechnicianAppointments technicianAppointments
        in technician.technicianAppointments) {
      if (technicianAppointments.date == formattedDay) {
        return !isDayFullyBooked(
            technicianAppointments, technician.workHours[dayOfWeek]!);
      }
    }

    return true;
  }

  List<String> getTimeSlotsForDay(DateTime? daySelected, BuildContext context) {
    if (daySelected == null || !hasAvailableStaff) {
      return [];
    }

    List<String> availableTimeSlots = [];

    DateTime now = DateTime.now();

    Technician technician = _clinicBranches[_selectedBranchIndex]
        .technicians[_selectedTechnicianIndex];

    dynamic workHours =
        technician.workHours[DateFormat('EEEE').format(daySelected)];

    if (workHours != null) {
      DateTime startWork = DateFormat('HH:mm:ss').parse(workHours.start);
      DateTime endWork = DateFormat('HH:mm:ss').parse(workHours.end);

      DateTime slotStart, slotStart1, slotEnd;

      while (startWork.isBefore(endWork)) {
        slotStart = DateTime(daySelected.year, daySelected.month,
            daySelected.day, startWork.hour, startWork.minute);
        slotStart1 = startWork;
        slotEnd = startWork.add(const Duration(minutes: 30));

        bool isSlotAvailable = true;

        if ((slotStart.hour < now.hour ||
                (slotStart.hour == now.hour &&
                    slotStart.minute < now.minute)) &&
            slotStart.day == now.day) {
          isSlotAvailable = false;
        } else {
          for (TechnicianAppointments technicianAppointments
              in technician.technicianAppointments) {
            if (technicianAppointments.date ==
                DateFormat('yyyy-MM-dd').format(
                    DateFormat('yyyy-MM-dd').parse(daySelected.toString()))) {
              for (TechnicianAppointmentsDetails technicianAppointmentsDetails
                  in technicianAppointments.technicianAppointmentsDetails) {
                int hoursOffset = now.timeZoneOffset.inHours;

                DateTime appointmentStartTime = DateFormat('HH:mm:ss')
                    .parse(technicianAppointmentsDetails.start)
                    .add(Duration(hours: hoursOffset));

                DateTime appointmentEndTime = DateFormat('HH:mm:ss')
                    .parse(technicianAppointmentsDetails.end)
                    .add(Duration(hours: hoursOffset));

                if (slotStart1.isBefore(appointmentEndTime) &&
                    slotEnd.isAfter(appointmentStartTime)) {
                  isSlotAvailable = false;
                  break;
                }
              }
            }
            if (!isSlotAvailable) {
              break;
            }
          }
        }

        if (isSlotAvailable) {
          availableTimeSlots.add(DateFormat('h:mm a').format(slotStart));
        }

        startWork = slotEnd;
      }
    }

    _availableTimeSlots = availableTimeSlots;
    return availableTimeSlots;
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
