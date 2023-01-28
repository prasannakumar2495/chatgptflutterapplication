// To parse this JSON data, do
//
//     final chatGptEditApi = chatGptEditApiFromJson(jsonString);

import 'dart:convert';

ChatGptEditApi chatGptEditApiFromJson(String str) =>
    ChatGptEditApi.fromJson(json.decode(str));

String chatGptEditApiToJson(ChatGptEditApi data) => json.encode(data.toJson());

class ChatGptEditApi {
  ChatGptEditApi({
    required this.model,
    required this.input,
    required this.instruction,
  });

  String model;
  String input;
  String instruction;

  factory ChatGptEditApi.fromJson(Map<String, dynamic> json) => ChatGptEditApi(
        model: json["model"],
        input: json["input"],
        instruction: json["instruction"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "input": input,
        "instruction": instruction,
      };
}
