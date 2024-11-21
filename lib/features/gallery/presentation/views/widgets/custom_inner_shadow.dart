import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomInnerShadowInLastKitchen extends StatelessWidget {
  const CustomInnerShadowInLastKitchen({super.key, this.aspectRatio,required this.desc,required this.name});
  final double? aspectRatio;
  final String name;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio ?? 1225 / 100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
            color: AppColors.blackOpacity50),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Text(name,
                  style: AppFontStyles.extraBold40(context).copyWith(
                    color: AppColors.white,
                  )),
              Text(desc,
                  style: AppFontStyles.extraBold25(context).copyWith(
                    color: AppColors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
