import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionTimeWithAddButton extends StatelessWidget {
  const TransactionTimeWithAddButton({
    super.key,
    required this.formKey,
    required this.transactionModel,
    required this.addTransaction,
    this.onChangeDate,
    required this.isLoading,
  });
  final GlobalKey<FormState> formKey;
  final TransactionModel transactionModel;
  final void Function() addTransaction;
  final void Function(DateTime)? onChangeDate;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: CustomDatePicker(
            isReadOnly: false,
            formKey: formKey,
            format: 'd MMMM y - HH:mm',
            enableShowDayTime: true,
            recieveTime: transactionModel.transactionTime,
            changeDate: onChangeDate,
            labelText: "تاريخ المعاملة",
          ),
        ),
        const Expanded(child: SizedBox()),
        CustomPushContainerButton(
          borderRadius: 8,
          enableIcon: false,
          childInstead: isLoading
              ? const CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  "إضافة تحويل",
                  style: AppFontStyles.extraBoldNew16(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
          color: AppColors.green,
          onTap: isLoading ? null : addTransaction,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          pushButtomTextFontSize: 18,
        )
      ],
    );
  }
}
