import 'package:chatgptflutterapplication/ui/chatscreen.dart';
import 'package:chatgptflutterapplication/ui/editscreen.dart';
import 'package:chatgptflutterapplication/ui/imagesscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardSingleView extends StatelessWidget {
  final String typeName;
  const DashboardSingleView({
    super.key,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (typeName == 'Ask Questions') {
            Navigator.of(context).pushNamed(ChatScreen.routeName);
          } else if (typeName == 'Check Spellings') {
            Navigator.of(context).pushNamed(EditScreen.routeName);
          } else if (typeName == 'Generate Images') {
            Navigator.of(context).pushNamed(ImageScreen.routeName);
          }
        },
        child: Center(
          child: Text(
            typeName,
            style: GoogleFonts.roboto(),
          ),
        ),
      ),
    );
  }
}
