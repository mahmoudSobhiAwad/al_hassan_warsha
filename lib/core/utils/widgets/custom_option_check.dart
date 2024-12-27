import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({
    super.key,
    required this.label,
    required this.isSelected,
    this.onPressed,
  });

  final String label;
  final bool isSelected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            label,
            style: AppFontStyles.extraBoldNew16(context),
          ),
        ),
        Checkbox(
          activeColor: AppColors.green,
            value: isSelected,
            onChanged: (v) {
             onPressed!=null? onPressed!():null;
            }),
      ],
    );
  }
}
