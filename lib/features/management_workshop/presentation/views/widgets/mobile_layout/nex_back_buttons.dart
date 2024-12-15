import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class NextPageOrBackButtons extends StatelessWidget {
  const NextPageOrBackButtons({
    super.key,
    required this.currPageIndex,
    required this.nextOrBack,
  });

  final int currPageIndex;
  final void Function(bool) nextOrBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: currPageIndex == 0
                ? null
                : () {
                    nextOrBack(false);
                  },
            child: Text(
              "العودة",
              style: AppFontStyles.extraBold14(context).copyWith(
                  color: currPageIndex != 0
                      ? AppColors.blueGray
                      : AppColors.lightGray1),
            )),
        TextButton(
            onPressed: currPageIndex == 2
                ? null
                : () {
                    nextOrBack(true);
                  },
            child: Text(
              "الخطوة القادمة",
              style: AppFontStyles.extraBold14(context).copyWith(
                  color: currPageIndex != 2
                      ? AppColors.blue
                      : AppColors.lightGray1),
            )),
      ],
    );
  }
}
