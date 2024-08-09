import 'package:shared_preferences/shared_preferences.dart';

class TheamSharredPreferences {
  static const PREF_KEY = "preferences";

  setTheam(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheam() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}
