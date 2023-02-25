import 'package:chatgptflutterapplication/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardSingleView extends StatelessWidget {
  final String typeName;
  const DashboardSingleView({
    super.key,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: InkWell(
          onTap: () {
            if (typeName == 'Ask Questions') {
              context.go('/$CHAT_SCREEN');
            } else if (typeName == 'Check Spellings') {
              context.go('/$EDIT_SCREEN');
            } else if (typeName == 'Generate Images') {
              context.go('/$IMAGE_SCREEN');
            }
          },
          child: Center(
            child: Text(
              typeName,
              style: GoogleFonts.roboto(),
            ),
          ),
        ),
      ),
    );
  }
}
