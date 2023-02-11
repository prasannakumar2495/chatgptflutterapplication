import 'package:flutter/material.dart';

class AllData {
  String message;
  String id;

  AllData({
    required this.id,
    required this.message,
  });
}

class AllDataProvider extends ChangeNotifier {
  final List<AllData> _list = [];

  List<AllData> get fetchAllData {
    return [..._list];
  }

  void addData(AllData allData) {
    _list.add(allData);
    debugPrint('Data Added to AllData: ${allData.message}');
    notifyListeners();
  }

  void deleteData(String dataID) {
    _list.removeWhere((element) => element.id == dataID);
    notifyListeners();
  }

  void clearAllData() {
    _list.clear();
    notifyListeners();
  }
}
