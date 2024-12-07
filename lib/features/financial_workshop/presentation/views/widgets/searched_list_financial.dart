import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/list_order_financial.dart';
import 'package:flutter/material.dart';

class SearchedListInFinancial extends StatelessWidget {
  const SearchedListInFinancial({
    super.key,
    required this.bloc,
  });

  final FinanicalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "عرض الفواتير الخاصة ب",
                style: AppFontStyles.bold19(context),
              ),
              Text(
                bloc.searchKeyWord,
                style: AppFontStyles.bold19(context),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  bloc.add(EnableOrDisableSearchEvent(status: false));
                },
                child: Text(
                  "العودة للرئيسية ",
                  style: AppFontStyles.bold19(context)
                      .copyWith(color: AppColors.blue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          bloc.searchedList.isNotEmpty
              ? ListOfOrdersInFinancial(
                  controller: bloc.scrollController,
                  orderList: bloc.searchedList,
                  downStep: (
                      {required String addedAmount,
                      required String pillId,
                      required String totalPayedAmount}) {
                    bloc.add(DownStepCounterEvent(
                        pillId: pillId,
                        totalPayedAmount: totalPayedAmount,
                        payedAmount: addedAmount));
                  },
                )
              : Center(
                  child: Text(
                    "لا يوجد اي فواتير مستحقة ",
                    style: AppFontStyles.extraBoldNew24(context),
                  ),
                ),
        ],
      ),
    );
  }
}
