class ClinicBranchModel {
  final int id;
  final String name;
  final List<Technician> technicians;

  ClinicBranchModel(
      {required this.id, required this.name, required this.technicians});

  factory ClinicBranchModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> techList = json['technicians'] as List<dynamic>? ?? [];
    List<Technician> technicianList =
        techList.map((i) => Technician.fromJson(i)).toList();

    return ClinicBranchModel(
      id: json['id'],
      name: json['name'],
      technicians: technicianList,
    );
  }
}

class Technician {
  final int id;
  final String name;
  final Map<String, WorkHours> workHours;
  final List<TechnicianAppointments> technicianAppointments;
  final List<Option> options;
  final List<ConsultationCard> consultationCard;

  Technician(
      {required this.id,
      required this.name,
      required this.workHours,
      required this.technicianAppointments,
      required this.options,
      required this.consultationCard});

  factory Technician.fromJson(Map<String, dynamic> json) {
    Map<String, WorkHours> workHoursMap = {};
    Map<String, dynamic>? jsonWorkHours =
        json['workHours'] as Map<String, dynamic>?;
    if (jsonWorkHours != null) {
      jsonWorkHours.forEach((day, hours) {
        workHoursMap[day] = WorkHours.fromJson(hours);
      });
    }

    List appointmentsList = json['appointments'] as List<dynamic>? ?? [];
    List<TechnicianAppointments> appointmentDays = appointmentsList
        .map((i) => TechnicianAppointments.fromJson(i))
        .toList();

    List optionsList = json['options'] as List<dynamic>? ?? [];
    List<Option> options = optionsList.map((i) => Option.fromJson(i)).toList();

    List consultationList = json['consultationCard'] as List<dynamic>? ?? [];
    List<ConsultationCard> consultationCards =
        consultationList.map((i) => ConsultationCard.fromJson(i)).toList();

    return Technician(
      id: json['id'],
      name: json['name'],
      workHours: workHoursMap,
      technicianAppointments: appointmentDays,
      options: options,
      consultationCard: consultationCards,
    );
  }
}

class Option {
  final int id;
  final String tag;
  final String type;

  Option({
    required this.id,
    required this.tag,
    required this.type,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      tag: json['tag'].toString(),
      type: json['type'].toString(),
    );
  }
}

class ConsultationCard {
  final int id;
  final int appointmentId;
  final String height;
  final String weight;
  final String skinType;
  final String sensitivity;
  final String chronicMedicalConditions;
  final String pacemaker;
  final String hormoneImbalances;
  final String metalOrMedicalDevicesImplanted;
  final bool thyroidProblem;
  final String allergies;
  final String skinProblems;
  final String medicationsAndSupplements;
  final String notes;

  ConsultationCard({
    required this.id,
    required this.appointmentId,
    required this.height,
    required this.weight,
    required this.skinType,
    required this.sensitivity,
    required this.chronicMedicalConditions,
    required this.pacemaker,
    required this.hormoneImbalances,
    required this.metalOrMedicalDevicesImplanted,
    required this.thyroidProblem,
    required this.allergies,
    required this.skinProblems,
    required this.medicationsAndSupplements,
    required this.notes,
  });

  factory ConsultationCard.fromJson(Map<String, dynamic> json) {
    return ConsultationCard(
      id: json['id'],
      appointmentId: json['appointment_id'],
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      skinType: json['skinType'].toString(),
      sensitivity: json['sensitivity'].toString(),
      chronicMedicalConditions: json['chronicMedicalConditions'].toString(),
      pacemaker: json['pacemaker'].toString(),
      hormoneImbalances: json['hormoneImbalances'].toString(),
      metalOrMedicalDevicesImplanted:
          json['metalOrMedicalDevicesImplanted'].toString(),
      thyroidProblem: json['thyroidProblem'],
      allergies: json['allergies'].toString(),
      skinProblems: json['skinProblems'].toString(),
      medicationsAndSupplements: json['medicationsAndSupplements'].toString(),
      notes: json['notes'].toString(),
    );
  }
}

class WorkHours {
  final String start;
  final String end;

  WorkHours({required this.start, required this.end});

  factory WorkHours.fromJson(Map<String, dynamic> json) {
    return WorkHours(
      start: json['start'],
      end: json['end'],
    );
  }
}

class TechnicianAppointments {
  final String date;
  final List<TechnicianAppointmentsDetails> technicianAppointmentsDetails;

  TechnicianAppointments({required this.date, required this.technicianAppointmentsDetails});

  factory TechnicianAppointments.fromJson(Map<String, dynamic> json) {
    List appointmentsList = json['appointments'] as List;
    List<TechnicianAppointmentsDetails> technicianAppointmentsDetails = appointmentsList
        .map((i) => TechnicianAppointmentsDetails.fromJson(i))
        .toList();

    return TechnicianAppointments(
      date: json['date'],
      technicianAppointmentsDetails: technicianAppointmentsDetails,
    );
  }
}

class TechnicianAppointmentsDetails {
  final String start;
  final String end;

  TechnicianAppointmentsDetails({required this.start, required this.end});

  factory TechnicianAppointmentsDetails.fromJson(Map<String, dynamic> json) {
    return TechnicianAppointmentsDetails(
      start: json['start'],
      end: json['end'],
    );
  }
}
