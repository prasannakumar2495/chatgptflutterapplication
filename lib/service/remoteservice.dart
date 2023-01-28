import 'dart:io';

import 'package:chatgptflutterapplication/models/completion/completionpost.dart';
import 'package:chatgptflutterapplication/models/completion/completionresponse.dart';
import 'package:chatgptflutterapplication/models/edit/editpostresponse.dart';
import 'package:chatgptflutterapplication/models/image/imagespost.dart';
import 'package:chatgptflutterapplication/models/image/imagespostresponse.dart';
import 'package:http/http.dart' as http;
import '../api/apidetails.dart';
import '../models/edit/editpost.dart';

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

  Future<ChatGptEditApiResponse> postChatGptEditApi(
      ChatGptEditApi request) async {
    var client = http.Client();
    var uri = Uri.parse(chatGptEditUrl);
    var response = await client.post(
      uri,
      body: chatGptEditApiToJson(request),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $chatGptApiKey',
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var data = chatGptEditApiResponseFromJson(response.body);
    return ChatGptEditApiResponse(
      object: data.object,
      created: data.created,
      choices: data.choices,
      usage: data.usage,
    );
  }

  Future<ChatGptImageApiResponse> postChatGptImage(
      ChatGptImageApi chatGptImageApi) async {
    var client = http.Client();
    var uri = Uri.parse(chatGptImageUrl);
    var response = await client.post(
      uri,
      body: chatGptImageApiToJson(chatGptImageApi),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $chatGptApiKey',
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var data = chatGptImageApiResponseFromJson(response.body);
    return ChatGptImageApiResponse(
      created: data.created,
      data: data.data,
    );
  }
}
