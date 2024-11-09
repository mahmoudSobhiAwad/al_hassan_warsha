import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class AppBarWithLinking extends StatelessWidget {
  const AppBarWithLinking({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.veryLightGray,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 38,
            ),
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Text(
          "الرئيسية",
          style: AppFontStyles.extraBold40(context),
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 40,
            )),
        Text(
          "مطبخ كلاسيك",
          style: AppFontStyles.extraBold40(context),
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 40,
            )),
        Text(
          "مطبخ رقم 1",
          style: AppFontStyles.extraBold40(context),
        ),
      ],
    );
  }
}
