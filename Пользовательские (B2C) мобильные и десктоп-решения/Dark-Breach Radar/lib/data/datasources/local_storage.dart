import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _lastCheckKey = 'last_check';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';

  static Future<String?> getEmail() async =>
      (await SharedPreferences.getInstance()).getString(_emailKey);

  static Future<void> setEmail(String email) async =>
      (await SharedPreferences.getInstance()).setString(_emailKey, email);

  static Future<DateTime?> lastCheck() async {
    final ts = (await SharedPreferences.getInstance()).getInt(_lastCheckKey);
    return ts == null ? null : DateTime.fromMillisecondsSinceEpoch(ts);
  }

  static Future<void> setLastCheck(DateTime t) async =>
      (await SharedPreferences.getInstance())
          .setInt(_lastCheckKey, t.millisecondsSinceEpoch);
}