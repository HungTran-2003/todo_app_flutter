import 'package:flutter/material.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? width;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.borderColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
        minimumSize: Size(width ?? 0, 0),
      ),
      child: Text(label, style: textStyle ?? AppTextStyles.bMediumMedium),
    );
  }
}
