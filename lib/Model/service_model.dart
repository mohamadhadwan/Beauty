class ServiceModel {
  final int id;
  final String name;
  final String type;
  final String description;
  final String fileUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.fileUrl,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      fileUrl: json['file_url'] ?? '',
    );
  }
}