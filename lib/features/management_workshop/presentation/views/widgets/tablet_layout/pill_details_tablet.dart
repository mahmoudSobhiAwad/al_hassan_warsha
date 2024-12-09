import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/interior_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/remian_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/total_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/payment_option_with_steps.dart';
import 'package:flutter/material.dart';

class BillDetailsInTablet extends StatelessWidget {
  const BillDetailsInTablet(
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "الفاتورة",
        style: AppFontStyles.bold19(context),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: TotalMoneyInBillDetails(
                      changeStepsCounter: changeStepsCounter,
                      enableController: enableController,
                      pillModel: pillModel,
                      formKey: formKey,
                      onTapToChangeRemain: onTapToChangeRemain)),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 4,
                  child: InteriorMoneyInBillDetails(
                      changeStepsCounter: changeStepsCounter,
                      enableController: enableController,
                      pillModel: pillModel,
                      formKey: formKey,
                      onTapToChangeRemain: onTapToChangeRemain)),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 4,
                  child: RemainMoneyInBillDetails(pillModel: pillModel)),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: BigInt.parse(convertToEnglishNumbers(pillModel.remian)) ==
                BigInt.from(0)
            ? Center(
                child: Text(
                  "تم استلام كل المبالغ المتبقية",
                  style: AppFontStyles.bold19(context),
                ),
              )
            : PayMentOptionRowWithSteps(pillModel: pillModel, onChangePayment: onChangePayment, changeStepsCounter: changeStepsCounter),
      ),
    ]);
  }
}
