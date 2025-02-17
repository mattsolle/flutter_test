import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.onBackPressed,
  });

  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onBackPressed != null
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              ),
            )
          : null,
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
