import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/step_down_in_each_order.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/stepper_amount_in_each_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class ContentOfFinancialTable extends StatelessWidget {
  const ContentOfFinancialTable({
    super.key,
    required this.orderName,
    required this.pillModel,
    required this.downStep,
    this.isTabletLayOut = false,
  });
  final PillModel pillModel;
  final String orderName;
  final bool isTabletLayOut;
  final void Function(
      {required String pillId,
      required String addedAmount,
      required String totalPayedAmount}) downStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray1, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isTabletLayOut)
                  Expanded(
                      child: CustomTextWithTheSameStyle(
                    text: orderName,
                  )),
                if (!isTabletLayOut) const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: pillModel.customerName,
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: pillModel.optionPaymentWay ==
                              OptionPaymentWay.atRecieve
                          ? isTabletLayOut
                              ? "استلام"
                              : "دفع عند الاستلام"
                          : isTabletLayOut
                              ? "تقسيط"
                              : "دفع بالتقسيط",
                    )),
                const Expanded(child: SizedBox()),
                if (!isTabletLayOut)
                  Expanded(
                      flex: 1,
                      child: CustomTextWithTheSameStyle(
                        textStyle: isTabletLayOut
                            ? AppFontStyles.meduim12(context)
                                .copyWith(letterSpacing: 2)
                            : AppFontStyles.bold18(context).copyWith(
                                letterSpacing: 2,
                              ),
                        text: pillModel.interior,
                      )),
                if (!isTabletLayOut) const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: isTabletLayOut
                          ? AppFontStyles.bold12(context)
                              .copyWith(letterSpacing: 3)
                          : AppFontStyles.bold18(context).copyWith(
                              letterSpacing: 3,
                            ),
                      text: convertToArabicNumbers(pillModel.remian),
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                        text: int.parse(convertToEnglishNumbers(
                                    pillModel.remian)) !=
                                0
                            ? convertToArabicNumbers(
                                pillModel.stepsCounter.toString())
                            : convertToArabicNumbers('0'))),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: AmountToDowStepInCustomerBill(
                        textStyle: isTabletLayOut
                            ? AppFontStyles.bold12(context)
                                .copyWith(letterSpacing: 2)
                            : AppFontStyles.bold18(context).copyWith(
                                letterSpacing: 2,
                              ),
                        enableSuffix: !isTabletLayOut,
                        pillModel: pillModel)),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        StepDownInBillCustomerItem(
          pillModel: pillModel,
          downStep: downStep,
          textStyle: isTabletLayOut
              ? AppFontStyles.extraBold12(context)
              : AppFontStyles.extraBold14(context),
        )
      ],
    );
  }
}
