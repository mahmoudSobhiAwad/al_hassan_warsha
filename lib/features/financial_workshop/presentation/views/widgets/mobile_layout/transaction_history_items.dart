import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/content_in_transaction_history.dart';
import 'package:flutter/material.dart';

class TransactionHistoryItemsListInMobileLayout extends StatelessWidget {
  const TransactionHistoryItemsListInMobileLayout({
    super.key,
    required this.scrollController,
    required this.transactionList,
    required this.deleteTrans,
  });

  final ScrollController scrollController;
  final List<TransactionModel> transactionList;
  final void Function(String transId) deleteTrans;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: transactionList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  await checkBeforeRemoveTransaction(context, fontSize: 18)
                      .then((value) {
                    if (value) {
                      deleteTrans(transactionList[index].transactionId ?? "");
                      return true;
                    }
                  });
                  return false;
                },
                background: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete,
                        color: AppColors.white,
                      )),
                ),
                key: Key("$index"),
                child: ContentInTransactionHistory(
                  isTabletLayout: true,
                  model: transactionList[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            }),
      ),
    );
  }
}
