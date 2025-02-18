import 'package:flutter/material.dart';

import '../theme/typography.dart';
import '../utils/spacings.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(x4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: x15,
            ),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.loraRegularBigHeadline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
