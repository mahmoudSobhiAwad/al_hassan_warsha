import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/pay_pill_in_customer_profile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/total_money.dart';
import 'package:flutter/material.dart';

class OneOrderItemInCustomerProfile extends StatelessWidget {
  const OneOrderItemInCustomerProfile(
      {super.key,
      required this.orderName,
      required this.pillModel,
      required this.stepDown,
      required this.navigteToEdit,
      this.textStyle,
      this.edgeInsets});

  final PillModel pillModel;
  final String orderName;
  final void Function() stepDown;
  final void Function() navigteToEdit;
  final TextStyle? textStyle;
  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    final payedAmountArabic = convertToArabicNumbers(
      (BigInt.parse(pillModel.payedAmount) +
              BigInt.parse(convertToEnglishNumbers(pillModel.interior)))
          .toString(),
    );

    final remainingAmount =
        int.parse(convertToEnglishNumbers(pillModel.remian));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGray1, width: 2.25),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  orderName,
                  style: textStyle ?? AppFontStyles.bold18(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: navigteToEdit,
                icon: const Icon(Icons.mode_edit_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TotalMoneyInBillDetails(
                  aboveTextStyle: textStyle,
                  enableController: true,
                  pillModel: pillModel,
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 4,
                child: CustomColumnWithTextInAddNewType(
                  text: "اجمالي المسدد",
                  textLabel: "",
                  enableBorder: true,
                  textInnerStyle: textStyle?.copyWith(letterSpacing: 3) ??
                      AppFontStyles.extraBoldNew16(context)
                          .copyWith(letterSpacing: 3),
                  readOnly: true,
                  textStyle: textStyle ?? AppFontStyles.extraBoldNew16(context),
                  controller: TextEditingController(text: payedAmountArabic),
                  suffixIcon:Text("جنية",style:  AppFontStyles.extraBoldNew16(context),)
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  flex: 4, child: DownStepMoneyFormField(pillModel: pillModel)),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: CustomPushContainerButton(
                  borderRadius: 12,
                  pushButtomTextFontSize: textStyle?.fontSize ?? 18,
                  pushButtomText: "تنزيل دفعة",
                  enableIcon: false,
                  onTap: remainingAmount > 0 ? stepDown : null,
                  color: remainingAmount > 0
                      ? AppColors.green
                      : AppColors.green.withOpacity(0.5),
                  padding: edgeInsets ??
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
