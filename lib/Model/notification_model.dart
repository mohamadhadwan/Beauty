class NotificationModel {
  final String id;
  final String type;
  final String notificationMessage;
  final bool read;
  final DateTime createdAt;
  final dynamic payload;

  NotificationModel({
    required this.id,
    required this.type,
    required this.notificationMessage,
    required this.read,
    required this.createdAt,
    required this.payload,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      type: json['type'],
      notificationMessage: json['notification_message'],
      read: json['read'],
      createdAt: DateTime.parse(json['createdAt']),
      payload: json['payload'],
    );
  }
}