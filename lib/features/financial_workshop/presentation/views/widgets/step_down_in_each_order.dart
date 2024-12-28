import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/material.dart';

class StepDownInBillCustomerItem extends StatelessWidget {
  const StepDownInBillCustomerItem({
    super.key,
    required this.pillModel,
    required this.downStep,
    this.textStyle,
  });

  final PillModel? pillModel;
  final void Function(
      {required String addedAmount,
      required String pillId,
      required String totalPayedAmount}) downStep;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if ((pillModel?.stepsCounter??0) > 0 || int.parse(pillModel?.remian??"0") > 0) {
          final steppedAmount =
              int.tryParse(convertToEnglishNumbers(pillModel?.steppedAmount)) ??
                  0;
          final remainAmount =
              int.parse(convertToEnglishNumbers(pillModel?.remian));

          if (steppedAmount != 0) {
            if (steppedAmount <= remainAmount) {
              downStep(
                  addedAmount: steppedAmount.toString(),
                  pillId: pillModel?.pillId??"",
                  totalPayedAmount:
                      (steppedAmount + int.parse(pillModel?.payedAmount??"0"))
                          .toString());
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
          color: int.parse(pillModel?.remian??"0") == 0
              ? AppColors.green.withOpacity(0.5)
              : AppColors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "تنزيل دفعة",
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
