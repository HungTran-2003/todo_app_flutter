import 'package:flutter/material.dart';

import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';

class AppTextStyles {
  AppTextStyles._();

  ///White
  static const TextStyle white = TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.w400);

  //Small
  static final TextStyle wSmall = white.copyWith(fontSize: AppDimens.fontsSmall);
  static final TextStyle wSmallMedium = wSmall.copyWith(fontWeight: FontWeight.w500);
  static final TextStyle wSmallSemiBold = wSmall.copyWith(fontWeight: FontWeight.w600);
  static final TextStyle wSmallBold = wSmall.copyWith(fontWeight: FontWeight.w700);

  //Medium
  static final TextStyle wMedium = white.copyWith(fontSize: AppDimens.fontsMedium);
  static final TextStyle wMediumMedium = wMedium.copyWith(fontWeight: FontWeight.w500);
  static final TextStyle wMediumSemiBold = wMedium.copyWith(fontWeight: FontWeight.w600);
  static final TextStyle wMediumBold = wMedium.copyWith(fontWeight: FontWeight.w700);

  //MaxLarge
  static final TextStyle wMaxLarge = white.copyWith(fontSize: AppDimens.fontMaxLarge);
  static final TextStyle wMaxLargeMedium = wMaxLarge.copyWith(fontWeight: FontWeight.w500);
  static final TextStyle wMaxLargeSemiBold = wMaxLarge.copyWith(fontWeight: FontWeight.w600);

  ///Black
  static const TextStyle black = TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w400);

  //Medium
  static final TextStyle bMedium = black.copyWith(fontSize: AppDimens.fontsMedium);
  static final TextStyle bMediumMedium = bMedium.copyWith(fontWeight: FontWeight.w500);
  static final TextStyle bMediumSemiBold = bMedium.copyWith(fontWeight: FontWeight.w600);

}