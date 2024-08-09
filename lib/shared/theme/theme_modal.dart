import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:lcs/Sharred%20Preferences/theam_sharred_preferences.dart';
import 'package:library_app_sample/shared/theme/shared_pref.dart';

class TheamModal extends ChangeNotifier {
  late bool _isDark;
  late TheamSharredPreferences theamSharredPreferences;
  bool get isDark => _isDark;

  TheamModal() {
    _isDark = false;
    theamSharredPreferences = TheamSharredPreferences();
    getTheamPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    theamSharredPreferences.setTheam(value);
    notifyListeners();
  }

  getTheamPreferences() async {
    _isDark = await theamSharredPreferences.getTheam();
    notifyListeners();
  }
}
