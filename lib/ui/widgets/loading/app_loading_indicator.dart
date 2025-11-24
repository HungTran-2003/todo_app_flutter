import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color valueColor;

  const AppLoadingIndicator({super.key, this.valueColor = Colors.blueAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
