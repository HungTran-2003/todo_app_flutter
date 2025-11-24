import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_svgs.dart';

class AppIconButton extends StatelessWidget {
  final String assetIcon;
  final VoidCallback onPressed;
  final Color? colorBorder;

  const AppIconButton({
    super.key,
    required this.assetIcon,
    required this.onPressed,
    this.colorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.btNormal,
      width: AppDimens.btNormal,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(assetIcon, height: 24, width: 24),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(getColor(assetIcon)),
          shape: WidgetStateProperty.all(
            CircleBorder(
              side: BorderSide(
                width: 2,
                color: colorBorder ?? Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(String value) {
    switch (value) {
      case AppSvgs.note:
        return AppColors.iconTask;
      case AppSvgs.calendar:
        return AppColors.iconEvent;
      case AppSvgs.goal:
        return AppColors.iconGoal;
    }
    return Colors.white;
  }
}
