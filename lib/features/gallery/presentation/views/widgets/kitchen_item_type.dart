import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class KitchenTypeItem extends StatelessWidget {
  const KitchenTypeItem({super.key, this.mainAxisAlignment});
  final MainAxisAlignment? mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "مطبخ امريكي",
          style: AppFontStyles.extraBold28(context).copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          "(30)",
          style: AppFontStyles.extraBold20(context)
              .copyWith(color: AppColors.lightGray1),
        ),
      ],
    );
  }
}