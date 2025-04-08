import 'package:flutter/material.dart';

class MockCachedNetworkImageWidget extends StatelessWidget {
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit? boxFit;
  final String? heroTag;
  final String imgUrl;
  final Widget? errorWidget;

  const MockCachedNetworkImageWidget({
    super.key,
    required this.imgUrl,
    this.imgHeight,
    this.imgWidth,
    this.boxFit,
    this.heroTag,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgHeight ?? 88,
      width: imgWidth ?? 88,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image, size: 24, color: Colors.grey),
    );
  }
}
