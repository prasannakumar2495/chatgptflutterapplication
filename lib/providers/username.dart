import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../util/constants.dart';

class UserName {
  String userName;
  UserName({
    required this.userName,
  });
}

class UserNameProvider extends ChangeNotifier {
  final UserName _userName = UserName(userName: '');

  String get fetchUserName {
    fetchUserNameFuture.then((value) {
      _userName.userName = value;
      notifyListeners();
    });
    return _userName.userName;
  }

  Future<String> get fetchUserNameFuture async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sharedPreferences.getString(USER_NAME_KEY).isEmptyOrNull) {
      return '';
    } else {
      _userName.userName = sharedPreferences.getString(USER_NAME_KEY)!;
      notifyListeners();
    }
    return _userName.userName;
  }

  Future<void> updateUserName(String userName) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(
      USER_NAME_KEY,
      userName,
    );
    _userName.userName = userName;
    notifyListeners();
  }

  Future<void> clearUserName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(
      USER_NAME_KEY,
      '',
    );
    _userName.userName = '';
    notifyListeners();
  }
}
