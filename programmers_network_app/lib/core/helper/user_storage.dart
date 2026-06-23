import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String emailKey = "saved_email";

  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  static Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(emailKey);
  }
}
