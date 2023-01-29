import 'package:chatgptflutterapplication/providers/chatmessagesprovider.dart';
import 'package:chatgptflutterapplication/widget/chatmessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class EditScreen extends StatefulWidget {
  static const routeName = 'editScreen';
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _controller = TextEditingController();
  late ChatMessagesProvider provider;
  bool isTyping = false;

  @override
  void initState() {
    provider = Provider.of<ChatMessagesProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    provider.clearAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Spellings'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: provider.fetchAllSpellingMessages.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return ChatMessage(
                    text: provider.fetchAllSpellingMessages[index].message,
                    sender: provider.fetchAllSpellingMessages[index].sender,
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
              child: _buildSentenceComposer(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentenceComposer(ChatMessagesProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) => sendMessage(provider),
            controller: _controller,
            decoration:
                const InputDecoration(hintText: 'Enter the Sentence...'),
          ),
        ),
        IconButton(
          onPressed: () => sendMessage(provider),
          icon: const Icon(Icons.send_rounded),
        ),
      ],
    ).px16();
  }

  void sendMessage(ChatMessagesProvider provider) {
    setState(() {
      isTyping = true;
    });
    var message = ChatMessagesDataClass(
      message: _controller.text.trim().capitalized,
      sender: 'User',
    );
    provider.addSpellingMessages(message);

    var response = provider.postSpellingMessages(message);
    response.then((value) {
      var chatMessage = ChatMessagesDataClass(
        sender: 'Bot',
        message: value.choices[0].text.trim().capitalized,
      );
      provider.addSpellingMessages(chatMessage);
      setState(() {
        isTyping = false;
      });
    });

    _controller.clear();
  }
}
