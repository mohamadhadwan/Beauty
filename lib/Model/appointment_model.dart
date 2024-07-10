class AppointmentsModel {
  final int id;
  final DateTime start;
  final int duration;
  final String status;
  final List<ClinicBranch>? clinicBranch;
  final List<Patient>? patient;

  AppointmentsModel({
    required this.id,
    required this.start,
    required this.duration,
    required this.status,
    required List<ClinicBranch>? clinicBranch,
    required List<Patient>? patient,
  }) : clinicBranch = clinicBranch ?? [],
        patient = patient ?? [];

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      id: json["id"] ?? 0,
      start: DateTime.parse(json["start"] ?? "1990-01-01T17:00:00.033Z"),
      duration: json["duration"] ?? 0,
      status: json["status"] ?? "",
      clinicBranch: json["clinic_branch"] != null
          ? [ClinicBranch.fromJson(json["clinic_branch"])]
          : [],
      patient: json["patient"] != null
          ? [Patient.fromJson(json["patient"])]
          : [],
    );
  }

}

class ClinicBranch {
  final String description;
  final String location;
  final String address;
  final List<User>? user;

  ClinicBranch({
    required this.description,
    required this.location,
    required this.address,
    required this.user,
  });

  factory ClinicBranch.fromJson(Map<String, dynamic> json) => ClinicBranch(
    description: json["description"] ?? "",
    location: json["location"] ?? "",
    address: json["address"] ?? "",
    user: json["user"] != null

        ? [User.fromJson(json["user"])]
        : [],
  );
}

class User {
  final String firstName;
  final String lastName;
  final String number;
  final int countryCode;

  User({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    number: json["number"] ?? "",
    countryCode: json["countryCode"] ?? 0,
  );
}

class Patient {
  final String unverifiedNumber;
  final String unverifiedCountryCode;

  Patient({
    required this.unverifiedNumber,
    required this.unverifiedCountryCode,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    unverifiedNumber: json["unverified_number"] ?? "",
    unverifiedCountryCode: json["unverified_country_code"] ?? "",
  );
}