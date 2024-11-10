import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class EmptyUploadMedia extends StatelessWidget {
  const EmptyUploadMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 70),
      decoration: BoxDecoration(
        color: AppColors.veryLightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ارفع بعض الصور ومقاطع الفيديو حتي تعرض المنتج بأفضل صورة ممكنة ",
            style: AppFontStyles.extraBold28(context),
          ),
          const Icon(
            Icons.cloud_upload,
            size: 50,
          )
        ],
      ),
    );
  }
}

