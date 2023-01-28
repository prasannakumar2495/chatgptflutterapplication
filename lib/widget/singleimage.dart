import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleImageWidget extends StatelessWidget {
  final String imageLink;
  const SingleImageWidget({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/loading1.gif',
            image: imageLink,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          InkWell(
            onTap: () async {
              await Clipboard.setData(
                ClipboardData(text: imageLink),
              ).then((value) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link is copied!'),
                  ),
                );
              });
            },
            child: Text(
              'Click to copy above image link!',
              style: GoogleFonts.roboto(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
