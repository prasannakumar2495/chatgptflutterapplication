// To parse this JSON data, do
//
//     final chatGptCompletionApi = chatGptCompletionApiFromJson(jsonString);

import 'dart:convert';

ChatGptCompletionApi chatGptCompletionApiFromJson(String str) =>
    ChatGptCompletionApi.fromJson(json.decode(str));

String chatGptCompletionApiToJson(ChatGptCompletionApi data) =>
    json.encode(data.toJson());

class ChatGptCompletionApi {
  ChatGptCompletionApi({
    required this.model,
    required this.prompt,
    required this.temperature,
    required this.maxTokens,
  });

  String model;
  String prompt;
  int temperature;
  int maxTokens;

  factory ChatGptCompletionApi.fromJson(Map<String, dynamic> json) =>
      ChatGptCompletionApi(
        model: json["model"],
        prompt: json["prompt"],
        temperature: json["temperature"],
        maxTokens: json["max_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": maxTokens,
      };
}
