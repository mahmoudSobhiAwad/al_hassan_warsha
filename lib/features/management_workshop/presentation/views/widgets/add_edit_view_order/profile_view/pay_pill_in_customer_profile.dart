import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayPillInCustomerProfile extends StatelessWidget {
  const PayPillInCustomerProfile({
    super.key,
    required this.orderModel,
    required this.stepDown,
  });

  final OrderModel orderModel;
  final void Function() stepDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: CustomColumnWithTextInAddNewType(
            text: "اجمالي المبلغ المسدد + المقدم",
            textLabel: "",
            enableBorder: true,
            textInnerStyle:
                AppFontStyles.bold24(context).copyWith(letterSpacing: 3),
            readOnly: true,
            textStyle: AppFontStyles.extraBold18(context),
            controller: TextEditingController(
              text: convertToArabicNumbers(
                  (BigInt.parse(orderModel.pillModel!.payedAmount) +
                          BigInt.parse(convertToEnglishNumbers(
                              orderModel.pillModel!.interior)))
                      .toString()),
            ),
            suffixText: "جنية",
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: CustomColumnWithTextInAddNewType(
            text: "  تنزيل دفعة ",
            textLabel: "",
            enableBorder: true,
            controller: TextEditingController(
                text: orderModel.pillModel?.steppedAmount),
            textStyle: AppFontStyles.extraBold18(context),
            onChanged: (value) {
              orderModel.pillModel!.steppedAmount = value ?? "0";
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
              )
            ],
            textInputType: TextInputType.number,
            suffixText: "جنية",
            textInnerStyle: AppFontStyles.extraBold24(context),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        CustomPushContainerButton(
          borderRadius: 12,
          pushButtomText: "تنزيل دفعة ",
          enableIcon: false,
          onTap: int.parse(convertToEnglishNumbers(orderModel.pillModel!.remian)) > 0 ? stepDown : null,
          color: int.parse(orderModel.pillModel!.remian) > 0
              ? AppColors.green
              : AppColors.green.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
