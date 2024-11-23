import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/material.dart';

class SelectedPaymentWay extends StatelessWidget {
  const SelectedPaymentWay(
      {super.key, required this.onPressed, required this.optionPaymentWay});
  final void Function(OptionPaymentWay) onPressed;
  final OptionPaymentWay optionPaymentWay;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "المبلغ المتبقي",
        style: AppFontStyles.extraBold18(context),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PaymentOptionWidget(
            label: "الدفع عند الاستلام",
            isSelected: optionPaymentWay == OptionPaymentWay.atRecieve,
            onPressed: () => onPressed(OptionPaymentWay.atRecieve),
          ),
          PaymentOptionWidget(
            label: "الدفع علي دفعات",
            isSelected: optionPaymentWay == OptionPaymentWay.onSteps,
            onPressed: () => onPressed(OptionPaymentWay.onSteps),
          ),
        ],
      )
    ]);
  }
}

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
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
      ),
    );
  }
}
