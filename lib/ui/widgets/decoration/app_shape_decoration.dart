import 'package:flutter/cupertino.dart';
import 'package:todo_app/common/app_colors.dart';

class AppShapeDecoration extends StatelessWidget {
  final double size;
  final Color? color;
  final BoxShape shape;
  final BoxBorder? boxBorder;

  const AppShapeDecoration({
    super.key,
    required this.size,
    this.color,
    this.shape = BoxShape.rectangle,
    this.boxBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? AppColors.btBGLightBlue,
        shape: shape,
        border: boxBorder,
      ),
    );
  }
}