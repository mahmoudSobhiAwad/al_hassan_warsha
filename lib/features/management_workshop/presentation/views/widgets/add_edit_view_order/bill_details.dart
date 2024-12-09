import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/interior_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/number_of_steps.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/remian_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/selected_payment_way.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/total_money.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillDetails extends StatelessWidget {
  const BillDetails(
      {super.key,
      required this.pillModel,
      this.onChangePayment,
      this.formKey,
      this.onTapToChangeRemain,
      required this.enableController,
      this.changeStepsCounter});
  final PillModel pillModel;
  final void Function(OptionPaymentWay)? onChangePayment;
  final void Function(bool)? changeStepsCounter;
  final GlobalKey<FormState>? formKey;
  final void Function()? onTapToChangeRemain;
  final bool enableController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الفاتورة",
          style: AppFontStyles.extraBoldNew20(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TotalMoneyInBillDetails(
                      enableController: enableController,
                      pillModel: pillModel,
                      formKey: formKey,
                      onTapToChangeRemain: onTapToChangeRemain)),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: InteriorMoneyInBillDetails(
                      enableController: enableController,
                      pillModel: pillModel,
                      formKey: formKey,
                      onTapToChangeRemain: onTapToChangeRemain)),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: RemainMoneyInBillDetails(pillModel: pillModel)),
              const Expanded(flex: 1, child: SizedBox()),
              BigInt.parse(convertToEnglishNumbers(pillModel.remian)) ==
                      BigInt.from(0)
                  ? Center(
                      child: Text(
                        "تم استلام كل المبالغ المتبقية",
                        style: AppFontStyles.bold18(context),
                      ),
                    )
                  : Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: SelectedPaymentWay(
                                onPressed: onChangePayment,
                                optionPaymentWay: pillModel.optionPaymentWay,
                              )),
                          const Expanded(child: SizedBox()),
                          switch (pillModel.optionPaymentWay) {
                            OptionPaymentWay.onSteps => Expanded(
                                flex: 2,
                                child: NumberOfStepsInBillDetails(
                                    pillModel: pillModel,
                                    changeStepsCounter: changeStepsCounter)),
                            OptionPaymentWay.atRecieve => const SizedBox()
                          },
                        ],
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
