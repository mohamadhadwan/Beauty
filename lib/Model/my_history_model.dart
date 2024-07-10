class MyHistoryModel {
  final String service;
  final String start;
  final String technician;
  final String treatmentParameters;
  final String measurement;
  final String energy;
  final String frequency;
  final String pulseDuration;

  MyHistoryModel({
    required this.service,
    required this.start,
    required this.technician,
    required this.treatmentParameters,
    required this.measurement,
    required this.energy,
    required this.frequency,
    required this.pulseDuration,
  });

  factory MyHistoryModel.fromJson(Map<String, dynamic> json) {
    return MyHistoryModel(
      service: json['appointment']['service']['name'].toString(),
      start: json['appointment']['start'].toString(),
      technician: json['appointment']['technician']['name'].toString(),
      treatmentParameters: json['treatment_parameters'].toString(),
      measurement: json['measurement'].toString(),
      energy: json['energy'].toString(),
      frequency: json['frequency'].toString(),
      pulseDuration: json['pulse_duration'].toString(),
    );
  }
}