import 'package:flutter/material.dart';

import '../../utils/extensions/app_localization_extension.dart';
import '../../utils/extensions/context_extension.dart';

class OpenStatusWidget extends StatelessWidget {
  const OpenStatusWidget({
    super.key,
    required this.isOpen,
  });

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isOpen ? context.l10n.openNow : context.l10n.closed,
          style: context.appTypography.openRegularItalic,
        ),
        const SizedBox(width: 4),
        Material(
          color: isOpen
              ? context.appColors.openStatusColor
              : context.appColors.closedStatusColor,
          shape: const CircleBorder(),
          child: const SizedBox.square(
            dimension: 8,
          ),
        ),
      ],
    );
  }
}
