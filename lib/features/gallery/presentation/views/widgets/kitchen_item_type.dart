import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:flutter/material.dart';

class KitchenTypeItem extends StatelessWidget {
  const KitchenTypeItem(
      {super.key,
      required this.model,
      this.mainAxisAlignment,
      this.picked = false,
      this.index = 0,
      this.onTap,
      this.enableUnderline = true});
  final MainAxisAlignment? mainAxisAlignment;
  final OnlyTypeModel model;
  final bool enableUnderline;
  final bool picked;
  final int index;
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      
        onTap: () {
          onTap != null ? onTap!(index) : null;
        },
        contentPadding: const EdgeInsets.all(0),
        leading: Text(
          model.typeName,
          style: AppFontStyles.extraBoldNew24(context).copyWith(
            decoration: enableUnderline
                ? TextDecoration.underline
                : TextDecoration.none,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        title: Text(
          "${model.itemsCount}",
          style: AppFontStyles.extraBoldNew18(context)
              .copyWith(color: AppColors.lightGray1),
        ),
        trailing: (enableUnderline && picked)
            ? Container(
                width: 6,
                decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.circular(12)),
              )
            : const SizedBox());
  }
}
