import 'package:firebase_database/firebase_database.dart';

class ThemePreference {
  static const THEME_MODE = "MODE";
  static const DARK = "DARK";
  static const LIGHT = "LIGHT";

  setModeTheme(String theme) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("preferencias");
    await ref.update({
      "tema": theme,
    });
  }
}
