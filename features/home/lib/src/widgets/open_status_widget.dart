import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../restaurants/l10n/restaurant_l10n.dart';

class OpenStatusWidget extends StatelessWidget {
  const OpenStatusWidget({
    super.key,
    required this.isOpen,
  });

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = RestaurantL10n.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          isOpen ? l10n.opened : l10n.closed,
          style: AppTextStyles.openRegularText.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(width: x1),
        Container(
          width: x2,
          height: x2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOpen ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
