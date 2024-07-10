class SliderModel {
  final String fileUrl;
  final String type;
  final String link;
  final String serviceId;

  SliderModel({
    required this.fileUrl,
    required this.type,
    required this.link,
    required this.serviceId
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      fileUrl: json['file_url'] ?? '',
      type: json['type'] ?? '',
      link: json['link'] ?? '',
      serviceId: json['service_id'].toString(),
    );
  }
}