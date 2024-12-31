import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_option_check.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/tablet_layout/add_transaction_tablet.dart';
import 'package:flutter/material.dart';

class PayOrRecieveOptionWithPaymentMethod extends StatelessWidget {
  const PayOrRecieveOptionWithPaymentMethod({
    super.key,
    required this.transactionModel,
    required this.onChangeTransactionType,
    required this.onChangeTransactionMethod,
  });

  final TransactionModel transactionModel;
  final void Function(TransactionType) onChangeTransactionType;
  final void Function(TransactionMethod) onChangeTransactionMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: PayOrRecieveOption(
              primaryStyle: AppFontStyles.bold10(context),
              headerStyle: AppFontStyles.bold12(context),
              transactionModel: transactionModel,
              onChangeTransactionType: onChangeTransactionType),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Expanded(
                child: PaymentOptionWidget(
                    label: "كاش",
                    onPressed: () {
                      onChangeTransactionMethod(TransactionMethod.caching);
                    },
                    isSelected: transactionModel.transactionMethod ==
                        TransactionMethod.caching),
              ),
              Expanded(
                child: PaymentOptionWidget(
                    label: "تحويل بنكي",
                    onPressed: () {
                      onChangeTransactionMethod(TransactionMethod.visa);
                    },
                    isSelected: transactionModel.transactionMethod ==
                        TransactionMethod.visa),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
