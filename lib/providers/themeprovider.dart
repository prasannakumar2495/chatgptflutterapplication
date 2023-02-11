import 'package:flutter/material.dart';

class ThemeNotifier {
  bool darkTheme;
  ThemeNotifier({
    required this.darkTheme,
  });
}

class ThemeNotifierProvider extends ChangeNotifier {
  final ThemeNotifier data = ThemeNotifier(darkTheme: true);

  bool get fetchThemeNotifier {
    return data.darkTheme;
  }

  void updateTheme() {
    data.darkTheme = !data.darkTheme;
    notifyListeners();
  }
}
