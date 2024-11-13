import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/side_bar_model.dart';
import 'package:flutter/material.dart';

class CustomFinancialSideBarItem extends StatelessWidget {
  const CustomFinancialSideBarItem(
      {super.key,
      required this.model,
      required this.picked,
      required this.onTap});
  final FinancialSideBarModel model;
  final bool picked;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      leading: Text(
        model.title,
        style: picked
            ? AppFontStyles.extraBold24(context)
                .copyWith(color: AppColors.brown)
            : AppFontStyles.regular22(context).copyWith(color: AppColors.brown),
      ),
      title: Icon(
        model.iconData,
        color: AppColors.brown,
        size: picked ? 30 : null,
      ),
      trailing: picked
          ? Container(
              width: 6,
              decoration: BoxDecoration(
                  color: AppColors.brown,
                  borderRadius: BorderRadius.circular(12)),
            )
          : const SizedBox(),
    );
  }
}


