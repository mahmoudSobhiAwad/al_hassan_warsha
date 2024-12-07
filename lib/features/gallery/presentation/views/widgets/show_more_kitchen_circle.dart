import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';

class ShowMoreCirlcle extends StatelessWidget {
  const ShowMoreCirlcle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: customLinearGradient()),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "عرض المزيد ",
              style: AppFontStyles.extraBoldNew18(context)
                  .copyWith(color: AppColors.white),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}