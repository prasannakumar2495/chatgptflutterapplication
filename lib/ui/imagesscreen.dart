import 'package:chatgptflutterapplication/providers/imagesprovider.dart';
import 'package:chatgptflutterapplication/widget/singleimage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  static const routeName = 'imageScreen';
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final _formKey = GlobalKey<FormState>();

  final sentenceController = TextEditingController();
  final numberOfImagesCotroller = TextEditingController();
  late ImagesProvider provider;
  bool isLoading = false;

  @override
  void initState() {
    provider = Provider.of<ImagesProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    provider.clearAllData();
    sentenceController.dispose();
    numberOfImagesCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Images'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: sentenceController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Request';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 2),
                  ),
                  hintText: 'Specify the type of image required...',
                  prefixIcon: const Icon(Icons.image_search_rounded),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: numberOfImagesCotroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 2),
                  ),
                  hintText: 'Specify the number of images requried...',
                  prefixIcon: const Icon(Icons.numbers_rounded),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: (() {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          provider.clearAllData();
                          var request = ImagesDataClass(
                            count:
                                int.parse(numberOfImagesCotroller.text.trim()),
                            sentence: sentenceController.text.trim(),
                          );
                          var response = provider.postImages(request);
                          response.then((value) {
                            for (var element in value.data) {
                              var imagesDataClass = ImagesDataClass(
                                count: int.parse(
                                    numberOfImagesCotroller.text.trim()),
                                sentence: sentenceController.text.trim(),
                                imageUrl: element.url,
                              );
                              provider.addImage(imagesDataClass);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      }),
                      icon: const Icon(Icons.search_rounded),
                      label: const Text(
                        'Search',
                      ),
                    ),
              const Divider(
                color: Colors.transparent,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.feetchAllImages.length,
                  itemBuilder: ((context, index) {
                    return SingleImageWidget(
                      imageLink: provider.feetchAllImages[index].imageUrl!,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
