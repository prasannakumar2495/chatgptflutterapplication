// To parse this JSON data, do
//
//     final chatGptImageApiResponse = chatGptImageApiResponseFromJson(jsonString);

import 'dart:convert';

ChatGptImageApiResponse chatGptImageApiResponseFromJson(String str) =>
    ChatGptImageApiResponse.fromJson(json.decode(str));

String chatGptImageApiResponseToJson(ChatGptImageApiResponse data) =>
    json.encode(data.toJson());

class ChatGptImageApiResponse {
  ChatGptImageApiResponse({
    required this.created,
    required this.data,
  });

  int created;
  List<Datum> data;

  factory ChatGptImageApiResponse.fromJson(Map<String, dynamic> json) =>
      ChatGptImageApiResponse(
        created: json["created"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.url,
  });

  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
