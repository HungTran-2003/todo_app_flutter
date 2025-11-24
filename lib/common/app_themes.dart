import 'package:flutter/material.dart';
import 'package:todo_app/common/app_colors.dart';

class AppThemes {
  static const _font = "Inter";

  ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: _font,
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
