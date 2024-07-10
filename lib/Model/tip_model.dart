class TipsModel {
  final String description;
  final bool isPublic;

  TipsModel({
    required this.description,
    required this.isPublic
  });

  factory TipsModel.fromJson(Map<String, dynamic> json) {
    return TipsModel(
      description: json['description'] ?? '',
      isPublic: json['isPublic'] ?? true,
    );
  }
}