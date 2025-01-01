import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/add_transaction_dialog.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/transaction_history_items.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistoryMobile extends StatelessWidget {
  const TransactionHistoryMobile({super.key, required this.bloc});
  final FinanicalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FilterOrdersWithMonthYear(
              titleStyle: AppFontStyles.bold18(context),
              month: bloc.currTransMonth,
              dateStyle: AppFontStyles.bold12(context),
              year: bloc.currTransYear,
              title: "تاريخ التحويلات",
              changeMonth: (month) {
                bloc.add(ChangeCurrentMonthEvent(currentMonth: month));
              },
              searchFor: () {
                bloc.add(GetAllTransactionEvent());
              },
              changeYear: (time) {
                bloc.add(ChangeCurrentYearEvent(year: time.year));
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: HeaderForTransactionHistory(
                enableLastWidget: false,
              ),
            ),
            TransactionHistoryItemsListInMobileLayout(
              transactionList: bloc.transactionList,
              scrollController: bloc.scrollController,
              deleteTrans: (id) {
                bloc.add(DeleteTransactionEvent(transactionId: id));
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return BlocBuilder<FinanicalBloc, FinanicalState>(
                        bloc: bloc,
                        builder: (context, state) {
                          return Dialog(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 10),
                              decoration: BoxDecoration(
                                  boxShadow: [customLowBoxShadow()],
                                  color: AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: AddTransactionInMobile(
                                isLoading: bloc.isLoadingTransaction,
                                onChangeDate: (time) {
                                  bloc.add(ChangeHistoryOfTransactionEvent(
                                      time: time));
                                },
                                transactionModel: bloc.transactionModel,
                                onSelectedsactionMethod: (value) {
                                  bloc.add(ChangeAllTransactionTypesEvent(
                                      type: value.valueEnSearh));
                                },
                                onChangeTransactionMethod:
                                    (TransactionMethod method) {
                                  bloc.add(ChangeTransactionMethodEvent(
                                      method: method));
                                },
                                onChangeTransactionType:
                                    (TransactionType method) {
                                  bloc.add(
                                      ChangePaymentTypeEvent(type: method));
                                },
                                formKey: bloc.formKey,
                                addTransaction: () {
                                  if (bloc.formKey.currentState!.validate()) {
                                    bloc.add(AddNewTransactionEvent());
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: AppColors.blueGray,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.swap_horiz,
                size: 30,
                color: AppColors.white,
              )),
        ),
      ],
    );
  }
}

