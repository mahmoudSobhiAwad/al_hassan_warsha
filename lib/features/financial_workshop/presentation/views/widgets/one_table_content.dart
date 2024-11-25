import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentOfFinancialTable extends StatelessWidget {
  const ContentOfFinancialTable(
      {super.key,
      required this.orderName,
      required this.pillModel,
      required this.downStep});
  final PillModel pillModel;
  final String orderName;
  final void Function({required String pillId, required String amount})
      downStep;

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
                Expanded(child: CustomTextWithTheSameStyle(text: orderName)),
                const Expanded(child: SizedBox()),
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
                          ? "دفع عند الاستلام"
                          : "دفع بالتقسيط",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.bold24(context),
                      text: pillModel.interior,
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.bold24(context),
                      text: pillModel.remian,
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.bold24(context),
                        text: pillModel.stepsCounter.toString())),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomTextFormField(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      fillColor: AppColors.white,
                      enableFill: true,
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9.]'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value == "0.0") {
                          return "المبلغ لا يمكن ان يكون خاليا ";
                        }
                        return null;
                      },
                      borderRadius: 8,
                      controller:
                          TextEditingController(text: pillModel.payedAmount),
                      onChanged: (value) {
                        pillModel.payedAmount = value;
                      },
                      borderWidth: 2,
                      borderColor: AppColors.lightGray1,
                      suffixText: "جنية",
                      labelWidget: Text(
                        "...................",
                        style: AppFontStyles.extraBold12(context)
                            .copyWith(color: AppColors.lightGray2),
                      ),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            // Check if stepsCounter is greater than 0
            if (pillModel.stepsCounter > 0) {
              // Validate if payedAmount is not empty, not "0.0", and a valid number
              final payedAmount = double.tryParse(pillModel.payedAmount.trim());
              final remainAmount = double.tryParse(pillModel.remian.trim());

              if (payedAmount != null && remainAmount != null) {
                if (payedAmount <= remainAmount) {
                  final difference =
                      (remainAmount - payedAmount).toStringAsFixed(2);

                  // Call the function with calculated amount and pillId
                  downStep(amount: difference, pillId: pillModel.pillId);
                } else {
                  showCustomSnackBar(context, "المبلغ غير صحيح",
                      backgroundColor: AppColors.red);
                }
              } else {
                showCustomSnackBar(context, "المبلغ غير صحيح",
                    backgroundColor: AppColors.red);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: pillModel.stepsCounter == 0
                  ? AppColors.green.withOpacity(0.5)
                  : AppColors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "تنزيل دفعة",
              style: AppFontStyles.extraBold16(context)
                  .copyWith(color: AppColors.white),
            ),
          ),
        )
      ],
    );
  }
}
