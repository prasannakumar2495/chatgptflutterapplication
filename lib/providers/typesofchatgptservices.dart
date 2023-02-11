import 'package:flutter/material.dart';

class TypesOfChatGptServices {
  String typeName;
  TypesOfChatGptServices({
    required this.typeName,
  });
}

class TypesOfChatGptServiceProvider extends ChangeNotifier {
  final List<TypesOfChatGptServices> services = [
    TypesOfChatGptServices(typeName: 'Ask Questions'),
    TypesOfChatGptServices(typeName: 'Check Spellings'),
    TypesOfChatGptServices(typeName: 'Generate Images'),
  ];

  List<TypesOfChatGptServices> get fetchAllServices {
    return [...services];
  }
}
