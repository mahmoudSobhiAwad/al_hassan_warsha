import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/rendering.dart';

BoxShadow customLowBoxShadow() {
  return const BoxShadow(
      blurRadius: 20, color: AppColors.blackOpacity25, offset: Offset(0, 4));
}