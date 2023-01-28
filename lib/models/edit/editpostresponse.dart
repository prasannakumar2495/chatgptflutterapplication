// To parse this JSON data, do
//
//     final chatGptEditApiResponse = chatGptEditApiResponseFromJson(jsonString);

import 'dart:convert';

ChatGptEditApiResponse chatGptEditApiResponseFromJson(String str) =>
    ChatGptEditApiResponse.fromJson(json.decode(str));

String chatGptEditApiResponseToJson(ChatGptEditApiResponse data) =>
    json.encode(data.toJson());

class ChatGptEditApiResponse {
  ChatGptEditApiResponse({
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
  });

  String object;
  int created;
  List<Choice> choices;
  Usage usage;

  factory ChatGptEditApiResponse.fromJson(Map<String, dynamic> json) =>
      ChatGptEditApiResponse(
        object: json["object"],
        created: json["created"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        usage: Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
      };
}

class Choice {
  Choice({
    required this.text,
    required this.index,
  });

  String text;
  int index;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
      };
}

class Usage {
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  int promptTokens;
  int completionTokens;
  int totalTokens;

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
