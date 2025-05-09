import 'package:flutter/material.dart';
import 'color.dart';

class AppStyle {
  static TextStyle get fieldText => const TextStyle(fontSize: 16,
        color: AppColors.secondaryContainer,
        fontWeight: FontWeight.w500,);
  static TextStyle get textButtonReg => const TextStyle(fontSize: 14,
        fontWeight: FontWeight.w400,);
  static TextStyle get textHeadline5Reg => const TextStyle(fontSize: 24,
        fontWeight: FontWeight.w400,);
  static TextStyle get textSubtitle1Reg => const TextStyle(fontSize: 16,
        fontWeight: FontWeight.w400,);
}
