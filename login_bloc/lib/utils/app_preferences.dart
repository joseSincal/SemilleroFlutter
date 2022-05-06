import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._privateConstructor();

  static final AppPreferences shared = AppPreferences._privateConstructor();
  
  // ignore: constant_identifier_names
  static const LANGUAJE_APP = "APP_LANGUAJE_SEMIFLUTTER";

  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
