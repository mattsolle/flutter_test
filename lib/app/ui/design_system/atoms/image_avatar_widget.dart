import 'package:flutter/material.dart';

class ImageAvatarWidget extends StatelessWidget {
  const ImageAvatarWidget({
    super.key,
    required this.image,
    required this.size,
    required this.shape,
  });

  final ImageProvider image;
  final double size;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: shape,
      child: Ink(
        height: size,
        width: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
