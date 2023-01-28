import 'dart:io';

import 'package:chatgptflutterapplication/models/completion/completionpost.dart';
import 'package:chatgptflutterapplication/models/completion/completionresponse.dart';
import 'package:http/http.dart' as http;
import '../api/api_details.dart';

class RemotesService {
  Future<ChatGptCompletionApiResponse> postChatGptCompletion(
      ChatGptCompletionApi chatGptCompletionApi) async {
    var client = http.Client();
    var uri = Uri.parse(chatGptCompletionUrl);
    var response = await client.post(
      uri,
      body: chatGptCompletionApiToJson(chatGptCompletionApi),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $chatGptApiKey',
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var data = chatGptCompletionApiResponseFromJson(response.body);

    return ChatGptCompletionApiResponse(
      id: data.id,
      object: data.object,
      created: data.created,
      model: data.model,
      choices: data.choices,
      usage: data.usage,
    );
  }
}