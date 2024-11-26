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
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            label,
            style: AppFontStyles.extraBold18(context),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.check_box_outline_blank_rounded,
                size: 33,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppColors.vibrantGreen,
              ),
          ],
        ),
      ],
    );
  }
}
