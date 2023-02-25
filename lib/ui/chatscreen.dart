import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgptflutterapplication/providers/alldata.dart';
import 'package:chatgptflutterapplication/providers/chatmessagesprovider.dart';
import 'package:chatgptflutterapplication/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:velocity_x/velocity_x.dart';

import '../widget/chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speechToText;

  bool isTyping = false;
  bool isListening = false;
  late ChatMessagesProvider provider;
  late AllDataProvider allDataProvider;

  @override
  void initState() {
    _speechToText = stt.SpeechToText();
    provider = Provider.of<ChatMessagesProvider>(context, listen: false);
    allDataProvider = Provider.of<AllDataProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    provider.clearAllData();
    _speechToText.stop();
    super.dispose();
  }

  void sendMessage(ChatMessagesProvider provider) {
    setState(() {
      isTyping = true;
    });
    var message = ChatMessagesDataClass(
      message: _controller.text.trim().capitalized,
      sender: 'User',
    );
    provider.addMessages(message);
    allDataProvider.addData(
      AllData(id: UniqueKey().toString(), message: message.message),
    );

    var response = provider.postMessages(message);
    response.then((value) {
      var chatMessage = ChatMessagesDataClass(
        sender: 'Bot',
        message: value.choices[0].text.trim().capitalized,
      );
      provider.addMessages(chatMessage);
      setState(() {
        isTyping = false;
      });
    });

    _controller.clear();
  }

  void onListen() async {
    if (isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) => debugPrint('onStatus: $status'),
        onError: (errorNotification) =>
            debugPrint('onError: $errorNotification'),
      );
      if (available) {
        _speechToText.listen(
          onResult: (result) {
            _controller.text = result.recognizedWords;
          },
        );
      } else {
        _speechToText.stop();
      }
    }
  }

  Widget _buildQuestionComposer(ChatMessagesProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) => sendMessage(provider),
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter the Query...'),
          ),
        ),
        IconButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              sendMessage(provider);
            } else {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Enter your query!'),
                ),
              );
            }
          },
          icon: const Icon(Icons.send_rounded),
        ),
        SizedBox(
          child: Consumer<ThemeNotifierProvider>(
            builder: (context, value, child) => AvatarGlow(
              endRadius: 20,
              repeat: true,
              duration: const Duration(milliseconds: 1000),
              glowColor: value.fetchTheme
                  ? Colors.white38
                  : const Color.fromARGB(255, 10, 11, 12),
              repeatPauseDuration: const Duration(milliseconds: 100),
              showTwoGlows: true,
              animate: isListening,
              child: IconButton(
                icon: Icon(
                  isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                ),
                onPressed: () {
                  setState(() {
                    isListening = !isListening;
                  });
                  if (isListening) {
                    onListen();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    var messages = provider.fetchAllMessages;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ask Questions',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatMessage(
                    text: messages[index].message,
                    sender: messages[index].sender,
                  );
                },
              ),
            ),
            if (isTyping)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                  left: 15.0,
                  top: 5.0,
                ),
                child: Text(
                  'Typing...',
                  style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildQuestionComposer(provider),
            ),
          ],
        ),
      ),
    );
  }
}
