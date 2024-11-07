import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomPaginationWidget extends StatelessWidget {
  const CustomPaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.veryLightGray2,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackOpacity20,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              )),
          ...List.generate(9, (index) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: index == 0
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            arabicNumbers[index],
                            style: AppFontStyles.extraBold24(context)
                                .copyWith(color: AppColors.white),
                          ))
                      : Text(arabicNumbers[index],
                          style: AppFontStyles.extraBold20(context))),
            );
          }),
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
              )),
        ],
      ),
    );
  }
}

List<String> arabicNumbers = [
  '١', // 1
  '٢', // 2
  '٣', // 3
  '٤', // 4
  '٥', // 5
  '٦', // 6
  '٧', // 7
  '٨', // 8
  '٩' // 9
];
