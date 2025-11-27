import 'package:flutter/material.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/widgets/button/app_icon_button.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback onPressed;
  final String? imageBackground;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    required this.onPressed,
    this.imageBackground,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.wMediumSemiBold),
      centerTitle: true,
      leadingWidth: 64,
      leading: Container(
          margin: const EdgeInsets.only(left: AppDimens.marginNormal),
          child: AppIconButton(assetIcon: AppSvgs.closeX, onPressed: onPressed)),
      actions: actions,
      flexibleSpace: imageBackground != null
          ? Image.asset(
        imageBackground!,
        fit: BoxFit.cover,       // Dùng cover để lấp đầy mọi khoảng trống
        width: double.infinity,  // Ép chiều ngang full
        height: double.infinity,
      )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}
