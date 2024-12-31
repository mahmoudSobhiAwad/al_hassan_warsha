import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionMoneyAmount extends StatelessWidget {
  const TransactionMoneyAmount({
    super.key,
    required this.formKey,
    required this.transactionModel,
    this.headerTextStyle,
  });

  final GlobalKey<FormState> formKey;
  final TransactionModel transactionModel;
  final TextStyle? headerTextStyle ;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      formKey: formKey,
      validator: (value) {
        if (value == null || value == '0') {
          return "المبلغ لا يمكن ان يكون خاليا ";
        }
        return null;
      },
      onChanged: (value) {
        transactionModel.transactionAmount = value ?? "0";
      },
      controller:
          TextEditingController(text: transactionModel.transactionAmount),
      textInputType: TextInputType.number,
      textInnerStyle: AppFontStyles.bold18(context).copyWith(letterSpacing: 3),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(
              r'[0-9\u0660-\u0669\u06F0-\u06F9]'), // Allow Arabic and English numerals only
        ),
      ],
      textStyle:headerTextStyle?? AppFontStyles.extraBoldNew16(context),
      enableBorder: true,
      text: "قيمة المبلغ",
      textLabel: ".......................",
      maxLine: 1,
      borderWidth: 2,
      suffixIcon: Text(
        "جنية",
        style: AppFontStyles.extraBoldNew16(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}
