import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/constants.dart';

class ThemeNotifier {
  bool darkTheme;
  ThemeNotifier({
    required this.darkTheme,
  });
}

class ThemeNotifierProvider extends ChangeNotifier {
  final ThemeNotifier data = ThemeNotifier(darkTheme: true);

  bool get fetchTheme {
    fetchThemeNotifierProvider.then((value) {
      data.darkTheme = value;
      notifyListeners();
    });
    return data.darkTheme;
  }

  Future<bool> get fetchThemeNotifierProvider async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    data.darkTheme = sharedPreferences.getBool(USER_THEME_KEY)!;
    notifyListeners();

    return data.darkTheme;
  }

  Future<void> updateTheme() async {
    data.darkTheme = !data.darkTheme;
    notifyListeners();

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(
      USER_THEME_KEY,
      data.darkTheme,
    );
  }

  Future<void> clearTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(
      USER_THEME_KEY,
      true,
    );
    data.darkTheme = true;
    notifyListeners();
  }
}
