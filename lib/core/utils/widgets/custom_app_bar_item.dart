import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({super.key,required this.text,required this.enable,this.textStyle});
  final String text;
  final bool enable;
  final TextStyle?textStyle;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style:textStyle?? AppFontStyles.extraBold50(context).copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          enable ?Container(
            margin: const EdgeInsets.only(top: 8,bottom: 8), 
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 8,
          ):const SizedBox(),
        ],
      ),
    );
  }
}