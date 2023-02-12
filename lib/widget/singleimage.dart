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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageLink,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
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
              style: GoogleFonts.roboto(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
