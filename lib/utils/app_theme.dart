import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Light Theme
ThemeData light = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18,
        letterSpacing: 1.5,
      ),
      subtitle2: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
  accentColor: Colors.red,
  iconTheme: IconThemeData(color: Colors.black),
);

///Dark Theme
ThemeData dark = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 1.5,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  accentColor: Colors.red,
  iconTheme: IconThemeData(color: Colors.white),
  brightness: Brightness.dark,
);

///Class to toggle the theme and notifies the widget listening.
class AppTheme extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences preferences;
  bool _darkTheme;

  AppTheme() {
    _darkTheme = false;
    _getThemeFromPref();
  }

  ///Returns darkTheme.
  ///
  ///Default light theme is applied.
  ///
  ///if darkTheme is true then the Dark Theme will be applied to the entire app.
  ///
  ///Othervise Light Theme will be applied
  bool get darkTheme => _darkTheme;

  ///toggles the darkTheme value and sets the value to preference.
  ///
  ///Then notifies all the listeners for changes.
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPref();
    notifyListeners();
  }

  ///Initializes the preferences.
  ///
  _initPref() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
  }

  ///Gets the theme value from preferences.
  ///
  _getThemeFromPref() async {
    await _initPref();
    _darkTheme = preferences.getBool(key) ?? false;
    notifyListeners();
  }

  ///Sets the theme value to preference.
  ///
  _saveToPref() async {
    await _initPref();
    preferences.setBool(key, _darkTheme);
  }
}
