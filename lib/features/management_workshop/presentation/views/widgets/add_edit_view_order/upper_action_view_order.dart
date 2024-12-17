import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';

class UpperButtonsInViewOrder extends StatelessWidget {
  const UpperButtonsInViewOrder({
    super.key,
    required this.navToEdit,
    required this.onTapForCustomerProfileView,
    required this.getPdfContract,
    this.edgeInsets,
    this.fontSize,
    this.iconSize,
  });

  final void Function() navToEdit;
  final void Function ()getPdfContract;
  final void Function() onTapForCustomerProfileView;
  final EdgeInsets? edgeInsets;
  final double? fontSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomPushContainerButton(
          borderRadius: 12,
          onTap: navToEdit,
          pushButtomText: "تعديل الطلب",
          iconBehind: Icons.edit,
          iconSize: iconSize ?? 30,
          pushButtomTextFontSize: fontSize,
          padding: edgeInsets ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        const SizedBox(
          width: 12,
        ),
        CustomPushContainerButton(
          borderRadius: 12,
          onTap: onTapForCustomerProfileView,
          pushButtomText: "عرض الملف الشخصي ",
          pushButtomTextFontSize: fontSize,
          iconBehind: Icons.person,
          color: AppColors.orange,
          iconSize: iconSize ?? 30,
          padding: edgeInsets ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        const SizedBox(
          width: 12,
        ),
        CustomPushContainerButton(
          borderRadius: 12,
          pushButtomTextFontSize: fontSize,
          onTap:getPdfContract,
          pushButtomText: " استخراج نسخة عقد",
          iconBehind: Icons.file_present_sharp,
          color: AppColors.blueGray,
          iconSize: iconSize ?? 30,
          padding: edgeInsets ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ],
    );
  }
}
