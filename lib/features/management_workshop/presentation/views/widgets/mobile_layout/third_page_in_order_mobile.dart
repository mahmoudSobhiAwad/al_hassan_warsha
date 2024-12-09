import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_new_order_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/interior_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/number_of_steps.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/remian_money.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/selected_payment_way.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/total_money.dart';
import 'package:flutter/material.dart';

class ThirdPageInOrderMobile extends StatelessWidget {
  const ThirdPageInOrderMobile(
      {super.key,
      required this.pillModel,
      required this.addOrder,
      required this.isLoading,
      required this.onTapToChangeRemain,
      required this.enableController,
      required this.changeStepsCounter,
      required this.onChangePayment,
      required this.formKey});
  final PillModel pillModel;
  final bool enableController;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final void Function()? onTapToChangeRemain;
  final void Function(OptionPaymentWay)? onChangePayment;
  final void Function(bool)? changeStepsCounter;
  final void Function() addOrder;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الفاتورة",
                  style: AppFontStyles.bold18(context),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TotalMoneyInBillDetails(
                          fontSizeInner: 18,
                          enableController: enableController,
                          pillModel: pillModel,
                          formKey: formKey,
                          onTapToChangeRemain: onTapToChangeRemain),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InteriorMoneyInBillDetails(
                        fontSizeInner: 18,
                        enableController: enableController,
                        pillModel: pillModel,
                        formKey: formKey,
                        onTapToChangeRemain: onTapToChangeRemain,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: RemainMoneyInBillDetails(
                        fontSizeInner: 18,
                        pillModel: pillModel,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BigInt.parse(convertToEnglishNumbers(pillModel.remian)) ==
                        BigInt.from(0)
                    ? Center(
                        child: Text(
                          "تم استلام كل المبالغ المتبقية",
                          style: AppFontStyles.bold16(context),
                        ),
                      )
                    : Row(
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
                const SizedBox(height: 20,),
                AddNewOrderButton(
                    edgeInsets:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: AppFontStyles.bold18(context)
                        .copyWith(color: AppColors.white),
                    formKey: formKey,
                    addOrder: addOrder,
                    isLoading: isLoading),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
