import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/number_of_steps.dart';
import 'package:flutter/material.dart';

class PayMentOptionRowWithSteps extends StatelessWidget {
  const PayMentOptionRowWithSteps({
    super.key,
    required this.pillModel,
    required this.onChangePayment,
    required this.changeStepsCounter,
  });

  final PillModel pillModel;
  final void Function(OptionPaymentWay p1)? onChangePayment;
  final void Function(bool p1)? changeStepsCounter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "طريقة التسديد",
                  style: AppFontStyles.extraBoldNew16(context),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: PaymentOptionWidget(
                        label: "الدفع عند الاستلام",
                        isSelected: pillModel.optionPaymentWay ==
                            OptionPaymentWay.atRecieve,
                        onPressed: () => onChangePayment == null
                            ? null
                            : onChangePayment!(OptionPaymentWay.atRecieve),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: PaymentOptionWidget(
                        label: "الدفع علي دفعات",
                        isSelected: pillModel.optionPaymentWay ==
                            OptionPaymentWay.onSteps,
                        onPressed: () => onChangePayment == null
                            ? null
                            : onChangePayment!(OptionPaymentWay.onSteps),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      switch (pillModel.optionPaymentWay) {
          OptionPaymentWay.onSteps => Expanded(
              
              child: NumberOfStepsInBillDetails(
                  pillModel: pillModel,
                  changeStepsCounter: changeStepsCounter)),
          OptionPaymentWay.atRecieve => const SizedBox()
        },
      ],
    );
  }
}
