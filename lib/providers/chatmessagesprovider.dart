import 'package:chatgptflutterapplication/models/completion/completionpost.dart';
import 'package:chatgptflutterapplication/models/completion/completionresponse.dart';
import 'package:chatgptflutterapplication/models/edit/editpost.dart';
import 'package:chatgptflutterapplication/models/edit/editpostresponse.dart';
import 'package:chatgptflutterapplication/service/remoteservice.dart';
import 'package:chatgptflutterapplication/util/constants.dart';
import 'package:flutter/material.dart';

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
  final List<ChatMessagesDataClass> spellingMessages = [];

  List<ChatMessagesDataClass> get fetchAllMessages {
    return [...messages];
  }

  List<ChatMessagesDataClass> get fetchAllSpellingMessages {
    return [...spellingMessages];
  }

  void addMessages(ChatMessagesDataClass message) {
    messages.insert(0, message);
    notifyListeners();
  }

  void addSpellingMessages(ChatMessagesDataClass message) {
    spellingMessages.insert(0, message);
    notifyListeners();
  }

  void clearAllData() {
    spellingMessages.clear();
    messages.clear();
  }

  Future<ChatGptCompletionApiResponse> postMessages(
      ChatMessagesDataClass message) async {
    var data = ChatGptCompletionApi(
      model: Constants.COMPLETION_MODEL,
      prompt: message.message,
      temperature: 0,
      maxTokens: 200,
    );
    var response = RemotesService().postChatGptCompletion(data);
    return response;
  }

  Future<ChatGptEditApiResponse> postSpellingMessages(
      ChatMessagesDataClass message) async {
    var data = ChatGptEditApi(
      model: Constants.EDIT_MODEL,
      input: message.message,
      instruction: 'Fix the spelling mistakes',
    );
    var response = RemotesService().postChatGptEditApi(data);
    return response;
  }
}
