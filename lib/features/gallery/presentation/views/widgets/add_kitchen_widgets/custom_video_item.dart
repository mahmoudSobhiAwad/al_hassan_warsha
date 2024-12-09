import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';

class CustomVideoItem extends StatelessWidget {
  const CustomVideoItem({super.key,this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * (width??0.2),
      height: context.screenHeight*0.2,
      decoration: BoxDecoration(
          color: AppColors.black, borderRadius: BorderRadius.circular(12)),
      child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.video_library_rounded,
            color: Colors.white,
            size: 50,
          )),
    );
  }
}