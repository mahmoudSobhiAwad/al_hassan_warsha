import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class DialogAddNewTypeActionButton extends StatelessWidget {
  const DialogAddNewTypeActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPushContainerButton(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
          pushButtomText: "إضافة",
          color: AppColors.green,
          enableIcon: false,
        ),
        const SizedBox(
          width: 20,
        ),
        CustomPushContainerButton(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
          pushButtomText: "إلغاء",
          color: AppColors.red,
          enableIcon: false,
        ),
      ],
    );
  }
}