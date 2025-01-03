import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/constants.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/list_order_financial.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/searched_list_financial.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/table_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class FinancialBody extends StatelessWidget {
  const FinancialBody({
    super.key,
    required this.bloc,
    this.isTabletLayOut = false,
  });

  final FinanicalBloc bloc;

  final bool isTabletLayOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          SearchBarInManagment(
            textStyle:
                isTabletLayOut ? AppFontStyles.extraBoldNew18(context) : null,
            enableCreateTable: false,
            searchList: searchListInFinanical,
            searchTextController: bloc.searchTextController,
            changeSearchType: (model) {
              bloc.add(ChangeSearchModelEvent(model: model));
            },
            searchFunc: () {
              if (bloc.searchModel.valueEnSearh.isNotEmpty &&
                  bloc.searchTextController.text.trim().isNotEmpty) {
                bloc.add(EnableOrDisableSearchEvent(status: true));
              } else {
                showCustomSnackBar(context, "حدد كلمة البحث او نوع البحث ",
                    backgroundColor: AppColors.orange);
              }
            },
            searchKey: bloc.searchModel,
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TableHeaderInFinancial(
              isTabletLayOut: isTabletLayOut,
              onFarz: (value) {
                bloc.add(ChangeSearchModelEvent(model: value, isFarz: true));
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          switch (bloc.searchMood) {
            true => !bloc.isLoadingSearch
                ? SearchedListInFinancial(
                    isTabletLayOut: isTabletLayOut,
                    searchKeyWord: bloc.searchTextController.text,
                    scrollController: bloc.scrollController,
                    searchedList: bloc.searchedList,
                    downStep: (
                        {required String addedAmount,
                        required String pillId,
                        required String totalPayedAmount}) {
                      bloc.add(DownStepCounterEvent(
                          pillId: pillId,
                          totalPayedAmount: totalPayedAmount,
                          payedAmount: addedAmount));
                    },
                    controlSearchState: () {
                      bloc.add(EnableOrDisableSearchEvent(status: false));
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            false => bloc.orderList.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد اي فواتير مستحقة ",
                        style: AppFontStyles.extraBoldNew24(context),
                      ),
                    ),
                  )
                : ListOfOrdersInFinancial(
                    isTabletLayOut: isTabletLayOut,
                    controller: bloc.scrollController,
                    orderList: bloc.orderList,
                    downStep: (
                        {required String addedAmount,
                        required String pillId,
                        required String totalPayedAmount}) {
                      bloc.add(DownStepCounterEvent(
                          pillId: pillId,
                          totalPayedAmount: totalPayedAmount,
                          payedAmount: addedAmount));
                    },
                  ),
          },
          const SizedBox(
            height: 10,
          ),
          bloc.totalLengthOfAllOrders > 8 && !bloc.searchMood
              ? CustomPaginationWidget(
                  length: (bloc.totalLengthOfAllOrders / 8).ceil(),
                  currentPage: bloc.pageIndex,
                  onPageChanged: (pageIndex) {
                    bloc.add(ChangePageInFetchOrderEvent(index: pageIndex));
                  },
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
