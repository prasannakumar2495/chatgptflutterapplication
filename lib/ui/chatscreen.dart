import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGPT;
  StreamSubscription? _streamSubscription;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    chatGPT = ChatGPT.instance;
    final request = CompleteReq(
      prompt: "Hello",
      model: kTranslateModelV3,
      max_tokens: 200,
    );
    _streamSubscription = chatGPT!
        .builder("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")
        .onCompleteStream(request: request)
        .listen((event) {});
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void sendMessage() {
    ChatMessage chatMessage = ChatMessage(
      text: _controller.text.capitalized.trim(),
      sender: "User",
    );
    setState(() {
      _messages.insert(0, chatMessage);
      isTyping = true;
    });
    _controller.clear();

    try {
      final request = CompleteReq(
        prompt: chatMessage.text,
        model: kTranslateModelV3,
        max_tokens: 200,
      );
      _streamSubscription = chatGPT!
          .builder("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")
          .onCompleteStream(request: request)
          .listen((response) {
        ChatMessage botMessage = ChatMessage(
          text: response!.choices[0].text.trim().capitalized,
          sender: "Bot",
        );
        Vx.log(response.choices[0].text);
        setState(() {
          _messages.insert(0, botMessage);
          isTyping = false;
        });
      });
    } on Exception {
      setState(() {
        isTyping = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error has occurred, please try again.'),
        ),
      );
    }
  }

  Widget _buildQuestionComposer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) => sendMessage(),
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter the Query...'),
          ),
        ),
        IconButton(
          onPressed: () => sendMessage(),
          icon: const Icon(Icons.send_rounded),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatGPT App',
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
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
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
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildQuestionComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
