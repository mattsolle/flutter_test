import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/image_not_available_widget.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imgUrl;
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit? boxFit;
  final String? heroTag;
  final Widget? errorWidget;

  const CachedNetworkImageWidget({
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
    final double imageHeight = imgHeight ?? 100;
    final double imageWidth = imgWidth ?? 100;

    if (kDebugMode && imgUrl.contains('example.com')) {
      return Container(
        height: imageHeight,
        width: imageWidth,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image, color: Colors.grey, size: 30),
      );
    }

    Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        height: imageHeight,
        width: imageWidth,
        imageUrl: imgUrl,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            errorWidget ??
            ImageNotAvailableWidget(
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            ),
      ),
    );

    return heroTag != null
        ? Hero(tag: heroTag!, child: imageWidget)
        : imageWidget;
  }
}
