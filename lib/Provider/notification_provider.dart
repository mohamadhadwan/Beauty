import 'package:beauty_wider/Model/notification_model.dart';
import 'package:beauty_wider/Core/app_imports.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  Map<DateTime, List<NotificationModel>> _groupedNotifications = {};
  bool _isLoading = true;

  List<NotificationModel> get notifications => _notifications;
  Map<DateTime, List<NotificationModel>> get groupedNotifications => _groupedNotifications;
  bool get isLoading => _isLoading;

  NotificationProvider() {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    if (_notifications.isEmpty) {
      _isLoading = true;
      notifyListeners();
    }

    try {

      // var data = await apiService.fetchNotifications();
      // _notifications = data.map<NotificationModel>((json) => NotificationModel.fromJson(json)).toList();
      groupNotificationsByDate();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
      rethrow;
    }
  }

  void groupNotificationsByDate() {
    _groupedNotifications = {};
    for (var notification in _notifications) {
      DateTime date = DateTime(notification.createdAt.year, notification.createdAt.month, notification.createdAt.day);
      if (_groupedNotifications.containsKey(date)) {
        _groupedNotifications[date]!.add(notification);
      } else {
        _groupedNotifications[date] = [notification];
      }
    }
  }

  Future<void> setAllAsRead() async {
    try {

      // await apiService.setAllAsRead();
    } catch (e) {
      _isLoading = false;
      rethrow;
    }
  }
}