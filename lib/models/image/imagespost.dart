// To parse this JSON data, do
//
//     final chatGptImageApi = chatGptImageApiFromJson(jsonString);

import 'dart:convert';

ChatGptImageApi chatGptImageApiFromJson(String str) =>
    ChatGptImageApi.fromJson(json.decode(str));

String chatGptImageApiToJson(ChatGptImageApi data) =>
    json.encode(data.toJson());

class ChatGptImageApi {
  ChatGptImageApi({
    required this.prompt,
    required this.n,
    required this.size,
  });

  String prompt;
  int n;
  String size;

  factory ChatGptImageApi.fromJson(Map<String, dynamic> json) =>
      ChatGptImageApi(
        prompt: json["prompt"],
        n: json["n"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "prompt": prompt,
        "n": n,
        "size": size,
      };
}
