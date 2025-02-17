import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';

class PriceCategoryWidget extends StatelessWidget {
  const PriceCategoryWidget({
    super.key,
    required this.price,
    required this.category,
  });

  final String? price;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (price != null)
          Text(
            price!,
            style: AppTextStyles.openRegularText,
          ),
        const SizedBox(width: x1),
        if (category != null)
          Text(
            category!,
            style: AppTextStyles.openRegularText,
          ),
      ],
    );
  }
}
