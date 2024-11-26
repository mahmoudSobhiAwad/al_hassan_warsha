import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
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
  });

  final FinanicalBloc bloc;

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
            searchList: searchListInFinanical,
            searchKeyWord: bloc.searchKeyWord,
            changeSearchType: (model) {
              bloc.add(ChangeSearchModelEvent(model: model));
            },
            searchFunc: () {
              bloc.add(EnableOrDisableSearchEvent(status: true));
            },
            changeSearchText: (value) {
              bloc.add(ChangeSearchKeyWordEvent(text: value));
            },
            searchKey: bloc.searchModel,
          ),
          const SizedBox(
            height: 24,
          ),
          const TableHeaderInFinancial(),
          const SizedBox(
            height: 10,
          ),
          switch (bloc.searchMood) {
            true => !bloc.isLoadingSearch
                ? SearchedListInFinancial(bloc: bloc)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            false => bloc.orderList.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد اي فواتير مستحقة ",
                        style: AppFontStyles.extraBold30(context),
                      ),
                    ),
                  )
                : ListOfOrdersInFinancial(
                    controller: bloc.scrollController,
                    orderList: bloc.orderList,
                    downStep: (
                        {required String amount, required String pillId}) {
                      bloc.add(DownStepCounterEvent(
                          pillId: pillId, remianAmount: amount));
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
