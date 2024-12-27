import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
class TransactionNameInAddingOne extends StatelessWidget {
  const TransactionNameInAddingOne({
    super.key,
    required this.formKey,
    required this.transactionModel,
  });

  final GlobalKey<FormState> formKey;
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      formKey: formKey,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "الاسم لا يمكن ان يكون خاليا ";
        }
        return null;
      },
      onChanged: (value) {
        transactionModel.transactionName = value ?? "";
      },
      controller: TextEditingController(text: transactionModel.transactionName),
      textStyle: AppFontStyles.extraBoldNew16(context),
      enableBorder: true,
      text: "المعاملة",
      borderWidth: 2,
      textLabel: "غرض التحويل",
      maxLine: 1,
    );
  }
}

