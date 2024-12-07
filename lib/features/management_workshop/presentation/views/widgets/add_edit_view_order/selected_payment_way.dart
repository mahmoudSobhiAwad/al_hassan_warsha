import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/material.dart';

class SelectedPaymentWay extends StatelessWidget {
  const SelectedPaymentWay(
      {super.key, this.onPressed, required this.optionPaymentWay});
  final void Function(OptionPaymentWay)? onPressed;
  final OptionPaymentWay optionPaymentWay;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "طريقة التسديد",
        style: AppFontStyles.extraBoldNew16(context),
      ),
      
      PaymentOptionWidget(
        label: "الدفع عند الاستلام",
        isSelected: optionPaymentWay == OptionPaymentWay.atRecieve,
        onPressed: () =>
            onPressed == null ? null : onPressed!(OptionPaymentWay.atRecieve),
      ),
      PaymentOptionWidget(
        label: "الدفع علي دفعات",
        isSelected: optionPaymentWay == OptionPaymentWay.onSteps,
        onPressed: () =>
            onPressed == null ? null : onPressed!(OptionPaymentWay.onSteps),
      ),
    ]);
  }
}

