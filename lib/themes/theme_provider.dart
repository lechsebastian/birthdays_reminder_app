import 'package:birthdays_reminder_app/themes/my_color.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode
        ? ThemeData.dark(useMaterial3: false).copyWith(
            primaryColor: MyColor().myPrimaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: MyColor().myPrimaryColor),
          )
        : ThemeData.light(useMaterial3: false).copyWith(
            primaryColor: MyColor().myPrimaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: MyColor().myPrimaryColor),
          );
  }
}
