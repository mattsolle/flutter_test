import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({
    super.key,
    this.size,
    this.isCircular = false,
  });

  final double? size;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: !isCircular ? BorderRadius.circular(x2) : null,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: const Icon(Icons.error_outline_outlined),
    );
  }
}
