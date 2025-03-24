import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool gridView = false;  
  void toggleGridView() {
    gridView =!gridView;
    notifyListeners();
  }
}