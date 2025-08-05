import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const init = InitializationSettings(android: android);
    await _plugin.initialize(init);
  }

  static Future<void> show(String title, String body) async {
    const android = AndroidNotificationDetails(
        'breach_channel', 'Breach Alerts', importance: Importance.high);
    await _plugin.show(
        0, title, body, const NotificationDetails(android: android));
  }
}