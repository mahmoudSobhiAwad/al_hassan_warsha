import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_widget.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction(
      {super.key,
      required this.transactionModel,
      required this.onChangeDate,
      required this.onChangeTransactionType,
      required this.onChangeTransactionMethod});
  final TransactionModel transactionModel;
  final void Function(DateTime time) onChangeDate;
  final void Function(TransactionMethod method) onChangeTransactionMethod;
  final void Function(TransactionType method) onChangeTransactionType;
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
                  onChanged: (value) {
                    transactionModel.transactionAmount = value ?? "0";
                  },
                  inputFormatters: [],
                  textStyle: AppFontStyles.extraBold18(context),
                  enableBorder: true,
                  text: "قيمة المبلغ",
                  textLabel: ".......................",
                  maxLine: 1,
                  borderWidth: 2,
                  suffixText: "جنية",
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
                flex: 2,
                child: CustomDatePicker(
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
