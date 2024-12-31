import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/constants.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/order_list_customer_pills.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/search_bar_mobile.dart';
import 'package:flutter/material.dart';

class CustomerBillsMobileView extends StatelessWidget {
  const CustomerBillsMobileView({super.key, required this.bloc});
  final FinanicalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "فواتير العملاء",
            style: AppFontStyles.extraBoldNew18(context),
          ),
          const SizedBox(
            height: 10,
          ),
          SearchBarInMobileManagement(
            searchedList: searchListInFinanical,
            searchKey: bloc.searchModel,
            enableSearch: () {
              bloc.add(EnableOrDisableSearchEvent(status: true));
            },
            changeSearchKey: (searchKey) {
              bloc.add(ChangeSearchModelEvent(model: searchKey));
            },
            searchTextController: bloc.searchTextController,
          ),
          const SizedBox(
            height: 12,
          ),
          if (bloc.searchMood)
            Row(
              children: [
                Text(
                  "عرض الفواتير الخاصة ب",
                  style: AppFontStyles.bold18(context),
                ),
                Text(
                  bloc.searchTextController.text,
                  style: AppFontStyles.bold18(context),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    bloc.add(EnableOrDisableSearchEvent(status: false));
                  },
                  child: Text(
                    "العودة للرئيسية ",
                    style: AppFontStyles.bold18(context)
                        .copyWith(color: AppColors.blue),
                  ),
                )
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          switch (bloc.searchMood) {
            true => bloc.isLoadingSearch
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : OrderListInCustomerBillMobileLayOut(
                    orderList: bloc.searchedList,
                    stepDown: (
                        {required String addedAmount,
                        required String pillId,
                        required String totalPayedAmount}) {
                      bloc.add(DownStepCounterEvent(
                          pillId: pillId,
                          totalPayedAmount: totalPayedAmount,
                          payedAmount: addedAmount));
                    },
                  ),
            false => OrderListInCustomerBillMobileLayOut(
                orderList: bloc.orderList,
                stepDown: (
                    {required String addedAmount,
                    required String pillId,
                    required String totalPayedAmount}) {
                  bloc.add(DownStepCounterEvent(
                      pillId: pillId,
                      totalPayedAmount: totalPayedAmount,
                      payedAmount: addedAmount));
                },
              )
          },
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
