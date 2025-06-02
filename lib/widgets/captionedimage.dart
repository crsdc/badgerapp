import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../config/sizes.dart';
import '../config/textstyles.dart';

class ImageCaptioned extends StatelessWidget {
  final String image;
  final String caption;

  const ImageCaptioned({
    Key? key,
    required this.image,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        const SizedBox(height: smallBreak),
        Center(
          child: Text(
            caption,
            style: sTStyle,
          ),
        ),
      ]
    );
  }
}
