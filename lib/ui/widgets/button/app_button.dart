import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_text_style.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String? assetIcon;
  final Color? bgColor;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.assetIcon,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.btCornerRadius),
        ),
        overlayColor: Colors.white.withAlpha(20),
        minimumSize: Size(
          width ?? double.infinity,
          height ?? AppDimens.btHeightLarge,
        ),
      ),
      child: _buildChildButton(),
    );
  }

  Widget _buildChildButton() {
    if (assetIcon == null) {
      return Text(label, style: AppTextStyles.wMediumBold);
    }
    return SvgPicture.asset(
      assetIcon!,
      width: 24,
      height: 24,
      semanticsLabel: label,
    );
  }
}
