import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const _isLoggedInKey = 'is_logged_in';
  static const _userEmailKey = 'user_email';

  // Save login state
  static Future<void> setLoginState(bool isLoggedIn, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, isLoggedIn);
    prefs.setString(_userEmailKey, email);
  }

  // Retrieve login state
  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Retrieve user's email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Clear login state
  static Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_isLoggedInKey);
    prefs.remove(_userEmailKey);
  }
}
