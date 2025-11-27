import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/common/app_text_style.dart';

class ItemSettingWidget extends StatelessWidget {
  final String assetIcon;
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  const ItemSettingWidget({
    super.key,
    required this.assetIcon,
    required this.title,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            SvgPicture.asset(
              assetIcon,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                color ?? Colors.black,
                BlendMode.srcIn,
              ),
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10.0),
            Text(title, style: AppTextStyles.bMediumMedium.copyWith(color: color)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 24),
          ],
        ),
      ),
    );
  }
}
