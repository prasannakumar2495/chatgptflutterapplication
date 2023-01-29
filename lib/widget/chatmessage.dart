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
        tileColor: sender == "User"
            ? const Color.fromARGB(255, 50, 50, 50)
            : const Color.fromARGB(255, 70, 70, 70),
        leading: CircleAvatar(
          backgroundColor:
              sender == "User" ? Colors.greenAccent : Colors.redAccent,
          child: Text(
            sender[0],
            style: GoogleFonts.roboto(color: Colors.black),
          ),
        ),
        title: Text(
          sender,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        subtitle: Text(
          text,
          style: GoogleFonts.roboto(color: Colors.white),
        ));
  }
}
