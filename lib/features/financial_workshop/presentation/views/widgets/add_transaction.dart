import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_widget.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction(
      {super.key,
      required this.transactionModel,
      required this.onChangeDate,
      required this.onChangeTransactionType,
      required this.formKey,
      required this.onChangeTransactionMethod});
  final TransactionModel transactionModel;
  final void Function(DateTime time) onChangeDate;
  final void Function(TransactionMethod method) onChangeTransactionMethod;
  final void Function(TransactionType method) onChangeTransactionType;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تحويل مالي",
          style: AppFontStyles.extraBold35(context),
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 4,
                child: CustomColumnWithTextInAddNewType(
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
                  controller: TextEditingController(
                      text: transactionModel.transactionName),
                  textStyle: AppFontStyles.extraBold18(context),
                  enableBorder: true,
                  text: "المعاملة",
                  borderWidth: 2,
                  textLabel: "غرض التحويل",
                  maxLine: 1,
                )),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 2,
                child: CustomColumnWithTextInAddNewType(
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
                  controller: TextEditingController(text: transactionModel.transactionAmount),
                  textInputType: TextInputType.number,
                  textInnerStyle:
                      AppFontStyles.bold24(context).copyWith(letterSpacing: 3),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                          r'[\u0660-\u0669\u06F0-\u06F9]'), // Arabic numerals only
                    ),
                  ],
                  textStyle: AppFontStyles.extraBold18(context),
                  enableBorder: true,
                  text: "قيمة المبلغ",
                  textLabel: ".......................",
                  maxLine: 1,
                  borderWidth: 2,
                  suffixIcon: Text(
                    "جنية",
                    style: AppFontStyles.extraBold18(context),
                    textAlign: TextAlign.center,
                  ),
                )),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 2,
                child: CustomContainerWithDropDownList(
                  headerText: "دفع/استلام",
                  primaryText: transactionModel.transactionType ==
                          TransactionType.recieve
                      ? "استلام"
                      : "دفع",
                  onSelected: (value) {
                    onChangeTransactionType(value.valueEnSearh);
                  },
                  dropDownList: [
                    SearchModel(
                        valueArSearh: "استلام",
                        valueEnSearh: TransactionType.recieve),
                    SearchModel(
                        valueArSearh: "دفع", valueEnSearh: TransactionType.buy),
                  ],
                )),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 3,
                child: CustomDatePicker(
                  
                  formKey: formKey,
                  format: 'd MMMM y - HH:mm',
                  recieveTime: transactionModel.transactionTime,
                  changeDate: (value) {
                    onChangeDate(value);
                  },
                  labelText: "تاريخ المعاملة",
                )),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "طريقة الدفع",
                      style: AppFontStyles.extraBold18(context),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    PaymentOptionWidget(
                        label: "كاش",
                        onPressed: () {
                          onChangeTransactionMethod(TransactionMethod.caching);
                        },
                        isSelected: transactionModel.transactionMethod ==
                            TransactionMethod.caching),
                    PaymentOptionWidget(
                        label: "تحويل بنكي",
                        onPressed: () {
                          onChangeTransactionMethod(TransactionMethod.visa);
                        },
                        isSelected: transactionModel.transactionMethod ==
                            TransactionMethod.visa),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
