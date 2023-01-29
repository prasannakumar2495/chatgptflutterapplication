import 'package:chatgptflutterapplication/models/image/imagespostresponse.dart';
import 'package:chatgptflutterapplication/service/remoteservice.dart';
import 'package:flutter/material.dart';

import '../models/image/imagespost.dart';

class ImagesDataClass {
  String? imageUrl;
  String sentence;
  int count;
  ImagesDataClass({
    this.imageUrl,
    required this.sentence,
    required this.count,
  });
}

class ImagesProvider extends ChangeNotifier {
  final List<ImagesDataClass> _listImages = [];

  List<ImagesDataClass> get feetchAllImages {
    return [..._listImages];
  }

  void addImage(ImagesDataClass image) {
    _listImages.insert(0, image);
    notifyListeners();
  }

  void clearAllData() {
    _listImages.clear();
  }

  Future<ChatGptImageApiResponse> postImages(
      ImagesDataClass imagesDataClass) async {
    var data = ChatGptImageApi(
      prompt: imagesDataClass.sentence,
      n: imagesDataClass.count,
      size: '1024x1024',
    );

    var response = RemotesService().postChatGptImage(data);
    return response;
  }
}
