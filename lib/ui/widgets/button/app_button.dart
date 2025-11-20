import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.btPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.btCornerRadius),
        ),
        overlayColor: Colors.white.withAlpha(20),
        minimumSize: Size(
          width ?? double.infinity,
          height ?? AppDimens.btHeightLarge,
        ),
      ),
      child: Text(label, style: AppTextStyles.wMediumBold,),
    );
  }
}
