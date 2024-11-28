import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/add_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/content_in_transaction_history.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';

class TranscationView extends StatelessWidget {
  const TranscationView({
    super.key,
    required this.bloc,
  });
  final FinanicalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            FilterOrdersWithMonthYear(
              month: bloc.currTransMonth,
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
              height: 24,
            ),
            const HeaderForTransactionHistory(),
            const SizedBox(
              height: 12,
            ),
            bloc.transactionList.isNotEmpty
                ? Expanded(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.35,
                      child: Scrollbar(
                        controller: bloc.scrollController,
                        thickness: 12,
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: ScrollConfiguration(
                          behavior:
                              const ScrollBehavior().copyWith(scrollbars: false),
                          child: ListView.separated(
                              controller: bloc.scrollController,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: bloc.transactionList.length,
                              itemBuilder: (context, index) {
                                return ContentInTransactionHistory(
                                  deleteTrans: (id) {
                                    bloc.add(DeleteTransactionEvent(
                                        transactionId: id));
                                  },
                                  model: bloc.transactionList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              }),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد تحويلات لهذه الفترة ",
                        style: AppFontStyles.extraBold24(context),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: bloc.formKey,
              child: AddTransaction(
                formKey: bloc.formKey,
                transactionModel: bloc.transactionModel,
                onChangeDate: (DateTime time) {
                  bloc.add(ChangeHistoryOfTransactionEvent(time: time));
                },
                onChangeTransactionMethod: (TransactionMethod method) {
                  bloc.add(ChangeTransactionMethodEvent(method: method));
                },
                onChangeTransactionType: (TransactionType method) {
                  bloc.add(ChangePaymentTypeEvent(type: method));
                },
                onChangeAllTransactionType: (method) {
                  bloc.add(ChangeAllTransactionTypesEvent(type: method));
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
                child: CustomPushContainerButton(
              onTap: () {
                if (bloc.formKey.currentState!.validate()) {
                  bloc.add(AddNewTransactionEvent());
                }
              },
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              pushButtomText: "إضافة تحويل",
              color: AppColors.green,
              borderRadius: 12,
            )),
          ],
        ),
      ),
    );
  }
}
