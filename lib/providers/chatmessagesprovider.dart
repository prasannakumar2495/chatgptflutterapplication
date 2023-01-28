import 'package:chatgptflutterapplication/models/completion/completionpost.dart';
import 'package:chatgptflutterapplication/models/completion/completionresponse.dart';
import 'package:chatgptflutterapplication/service/remoteservice.dart';
import 'package:chatgptflutterapplication/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessagesDataClass {
  String message;
  String sender;

  ChatMessagesDataClass({
    required this.message,
    required this.sender,
  });
}

class ChatMessagesProvider extends ChangeNotifier {
  final List<ChatMessagesDataClass> messages = [];

  List<ChatMessagesDataClass> get fetchAllMessages {
    return [...messages];
  }

  void addMessages(ChatMessagesDataClass message) {
    messages.insert(0, message);
    notifyListeners();
  }

  Future<ChatGptCompletionApiResponse> postMessages(
      ChatMessagesDataClass message) {
    var data = ChatGptCompletionApi(
      model: Constants.MODEL,
      prompt: message.message,
      temperature: 0,
      maxTokens: 200,
    );
    var response = RemotesService().postChatGptCompletion(data);
    return response;
  }
}
