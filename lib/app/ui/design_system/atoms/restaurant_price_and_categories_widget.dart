import 'package:flutter/material.dart';

import '../../utils/extensions/context_extension.dart';

class RestaurantPriceAndTagsWidget extends StatelessWidget {
  const RestaurantPriceAndTagsWidget({
    super.key,
    required this.price,
    required this.tags,
  });

  final String price;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      clipBehavior: Clip.antiAlias,
      children: [
        Text(
          price,
          style: context.appTypography.openRegularText,
        ),
        if (tags.isNotEmpty) ...[
          const SizedBox(
            width: 8,
          ),
          ...tags.map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  e,
                  style: context.appTypography.openRegularText,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
