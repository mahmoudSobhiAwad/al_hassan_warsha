import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:flutter/material.dart';

class KitchenTypeItem extends StatelessWidget {
  const KitchenTypeItem({super.key,required this.model, this.mainAxisAlignment});
  final MainAxisAlignment? mainAxisAlignment;
  final KitchenTypeModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        Text(
          model.typeName,
          style: AppFontStyles.extraBold28(context).copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          "${model.itemsCount}",
          style: AppFontStyles.extraBold20(context)
              .copyWith(color: AppColors.lightGray1),
        ),
      ],
    );
  }
}