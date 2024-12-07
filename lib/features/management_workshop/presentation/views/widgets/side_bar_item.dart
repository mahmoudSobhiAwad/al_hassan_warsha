import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/side_bar_model.dart';
import 'package:flutter/material.dart';

class SideBarManagementItem extends StatelessWidget {
  const SideBarManagementItem({super.key, required this.model});
  final SideBarManagementModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: model.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Icon(model.icon, color: Colors.white)),
          Text(model.numberOfItem,
              style: AppFontStyles.extraBoldNew24(context).copyWith(
                color: AppColors.white,
              )),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(model.title,
                style: AppFontStyles.extraBoldNew24(context).copyWith(
                  color: AppColors.white,
                )),
          )
        ],
      ),
    );
  }
}
