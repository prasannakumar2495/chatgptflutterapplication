import 'package:chatgptflutterapplication/providers/chatmessagesprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isTyping = false;

  void sendMessage(ChatMessagesProvider provider) {
    setState(() {
      isTyping = true;
    });
    var message = ChatMessagesDataClass(
      message: _controller.text.trim().capitalized,
      sender: 'User',
    );
    provider.addMessages(message);

    var response = provider.postMessages(message);
    response.then((value) {
      var chatMessage = ChatMessagesDataClass(
        sender: 'Bot',
        message: value.choices[0].text.trim().capitalized,
      );
      provider.addMessages(chatMessage);
    });

    _controller.clear();
    setState(() {
      isTyping = false;
    });
  }

  Widget _buildQuestionComposer(ChatMessagesProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) => sendMessage(provider),
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter the Query...'),
          ),
        ),
        IconButton(
          onPressed: () => sendMessage(provider),
          icon: const Icon(Icons.send_rounded),
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChatMessagesProvider>(context);
    var messages = provider.fetchAllMessages;

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
