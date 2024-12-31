import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/constants.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/tablet_layout/transaction_money_in_add.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/transaction_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';

class AddTransactionInTabletLayout extends StatelessWidget {
  const AddTransactionInTabletLayout(
      {super.key,
      required this.transactionModel,
      required this.onChangeDate,
      required this.onChangeTransactionType,
      required this.onChangeAllTransactionType,
      required this.formKey,
      required this.onChangeTransactionMethod});
  final TransactionModel transactionModel;
  final void Function(DateTime time) onChangeDate;
  final void Function(TransactionMethod method) onChangeTransactionMethod;
  final void Function(TransactionType method) onChangeTransactionType;
  final void Function(AllTransactionTypes method) onChangeAllTransactionType;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تحويل مالي",
          style: AppFontStyles.extraBoldNew26(context),
        ),
        Row(
          children: [
            Expanded(
                flex: 3,
                child: CustomContainerWithDropDownList(
                  headerText: "نوع المعاملة",
                  primaryText: switch (transactionModel.allTransactionTypes) {
                    AllTransactionTypes.interior => "مقدم",
                    AllTransactionTypes.stepDown => "تنزيل قسط",
                    AllTransactionTypes.pills => "فواتير",
                    AllTransactionTypes.salaries => "مرتبات",
                    AllTransactionTypes.buys => "مشتريات",
                    AllTransactionTypes.other => "اخري ..",
                  },
                  onSelected: (value) {
                    onChangeAllTransactionType(value.valueEnSearh);
                  },
                  dropDownList: allTransactionTypesList,
                )),
            const Expanded(child: SizedBox()),
            transactionModel.allTransactionTypes == AllTransactionTypes.other
                ? Expanded(
                    flex: 3,
                    child: TransactionNameInAddingOne(
                        formKey: formKey, transactionModel: transactionModel))
                : const SizedBox(),
            transactionModel.allTransactionTypes == AllTransactionTypes.other
                ? const Expanded(child: SizedBox())
                : const SizedBox(),
            Expanded(
                flex: 3,
                child: TransactionMoneyAmount(
                    formKey: formKey, transactionModel: transactionModel)),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: PayOrRecieveOption(
                  transactionModel: transactionModel,
                  onChangeTransactionType: onChangeTransactionType),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 3,
                child: CustomDatePicker(
                  isReadOnly: false,
                  formKey: formKey,
                  format: 'd MMMM y - HH:mm',
                  enableShowDayTime: true,
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
                      style: AppFontStyles.extraBoldNew16(context),
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

class PayOrRecieveOption extends StatelessWidget {
  const PayOrRecieveOption({
    super.key,
    required this.transactionModel,
    required this.onChangeTransactionType,
    this.headerStyle,
    this.primaryStyle,
  });

  final TransactionModel transactionModel;
  final void Function(TransactionType method) onChangeTransactionType;
  final TextStyle?headerStyle;
  final TextStyle?primaryStyle;

  @override
  Widget build(BuildContext context) {
    return CustomContainerWithDropDownList(
      primaryStyle: primaryStyle,
      headerStyle: headerStyle,
      headerText: "دفع/استلام",
      primaryText:
          transactionModel.transactionType == TransactionType.recieve
              ? "استلام"
              : "دفع",
      onSelected: (value) {
        onChangeTransactionType(value.valueEnSearh);
      },
      dropDownList: [
        SearchModel(
            valueArSearh: "استلام", valueEnSearh: TransactionType.recieve),
        SearchModel(valueArSearh: "دفع", valueEnSearh: TransactionType.buy),
      ],
    );
  }
}
