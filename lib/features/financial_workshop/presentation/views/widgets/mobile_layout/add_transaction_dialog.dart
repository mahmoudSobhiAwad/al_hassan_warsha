import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_widget_title.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/constants.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/pay_recieve_option_with_payment_method.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/transaction_time_with_add_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/tablet_layout/transaction_money_in_add.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/transaction_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';

class AddTransactionInMobile extends StatelessWidget {
  const AddTransactionInMobile({
    super.key,
    required this.transactionModel,
    required this.formKey,
    required this.onChangeTransactionType,
    required this.onChangeTransactionMethod,
    this.onSelectedsactionMethod,
    required this.addTransaction,
    this.onChangeDate,
    required this.isLoading,
  });
  final TransactionModel transactionModel;
  final GlobalKey<FormState> formKey;
  final void Function(TransactionType) onChangeTransactionType;
  final void Function(TransactionMethod) onChangeTransactionMethod;
  final void Function(SearchModel)? onSelectedsactionMethod;
  final void Function() addTransaction;
  final void Function(DateTime)? onChangeDate;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const DialogTitleWithNav(
            title: "اضافة تحويل",
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomContainerWithDropDownList(
                  primaryStyle: AppFontStyles.bold10(context),
                  headerText: "نوع المعاملة",
                  headerStyle: AppFontStyles.bold12(context),
                  primaryText: switch (transactionModel.allTransactionTypes) {
                    AllTransactionTypes.interior => "مقدم",
                    AllTransactionTypes.stepDown => "تنزيل قسط",
                    AllTransactionTypes.pills => "فواتير",
                    AllTransactionTypes.salaries => "مرتبات",
                    AllTransactionTypes.buys => "مشتريات",
                    AllTransactionTypes.other => "اخري ..",
                  },
                  onSelected: onSelectedsactionMethod,
                  dropDownList: allTransactionTypesList,
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 6,
                  child: TransactionMoneyAmount(
                      headerTextStyle: AppFontStyles.bold12(context),
                      formKey: formKey,
                      transactionModel: transactionModel)),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          transactionModel.allTransactionTypes == AllTransactionTypes.other
              ? TransactionNameInAddingOne(
                  headerStyle: AppFontStyles.bold12(context),
                  formKey: formKey,
                  transactionModel: transactionModel)
              : const SizedBox(),
          const SizedBox(
            height: 8,
          ),
          PayOrRecieveOptionWithPaymentMethod(
            transactionModel: transactionModel,
            onChangeTransactionType: onChangeTransactionType,
            onChangeTransactionMethod: onChangeTransactionMethod,
          ),
          const SizedBox(
            height: 8,
          ),
          TransactionTimeWithAddButton(
            formKey: formKey,
            transactionModel: transactionModel,
            addTransaction: addTransaction,
            onChangeDate: onChangeDate,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}

