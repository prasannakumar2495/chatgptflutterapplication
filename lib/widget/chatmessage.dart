import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  const ChatMessage({
    super.key,
    required this.text,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor:
              sender == "User" ? Colors.greenAccent : Colors.redAccent,
          child: Text(
            sender[0],
          ),
        ),
        title: Text(
          sender,
          style: GoogleFonts.roboto(),
        ),
        subtitle: Text(
          text,
          style: GoogleFonts.roboto(),
        ));
  }
}
