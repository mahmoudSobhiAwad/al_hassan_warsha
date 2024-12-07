import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filterd_order_list.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/searched_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class ManagmentBody extends StatelessWidget {
  const ManagmentBody({
    super.key,
    required this.bloc,
    this.enableSideBar = true,
    this.farzWidget,
  });

  final ManagementBloc bloc;
  final bool enableSideBar;
  final Widget?farzWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        enableSideBar
            ? Expanded(
                child: SideBarManagement(
                neverLength: bloc.ordersList
                    .where((item) => item.orderStatus != OrderStatus.finished)
                    .length,
                finishedLength: bloc.ordersList
                    .where((item) => item.orderStatus == OrderStatus.finished)
                    .length,
                totalLength: bloc.ordersList.length,
                nearLenght: bloc.ordersList
                    .where((item) => item.orderStatus == OrderStatus.veryNear)
                    .length,
                changeIndex: (index) {
                  bloc.add(ChangeCategrizedListEvent(index: index));
                },
                currIndex: bloc.currIndex,
              ))
            : const SizedBox(),
        Expanded(
          flex: 4,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  SearchBarInManagment(
                    searchList: searchListInOrders,
                    changeSearchType: (text) {
                      bloc.add(ChangeSearchKeyEvent(searchKey: text));
                    },
                    searchFunc: () {
                      if (bloc.searchKeyWord.trim().isNotEmpty &&
                          bloc.searchKey.valueArSearh.isNotEmpty) {
                        bloc.add(SearchForOrderEvent(enable: true));
                      } else {
                        showCustomSnackBar(
                            context, "حدد كلمة البحث او نوع البحث ",
                            backgroundColor: AppColors.orange);
                      }
                    },
                    searchKeyWord: bloc.searchKeyWord,
                    searchKey: bloc.searchKey,
                    changeSearchText: (text) {
                      bloc.searchKeyWord = text;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  switch (bloc.enableSearchMode) {
                    true => Expanded(
                      child: SearchedOrderResutl(
                        searchKey: bloc.searchKeyWord,
                        bloc: bloc,
                        backToMain: () {
                          bloc.add(SearchForOrderEvent(enable: false));
                        },
                        searchedList: bloc.searchList,
                        isSearchLoading: bloc.isSearchLoading,
                      ),
                    ),
                    false => Expanded(
                          child: OrderListWithFilter(
                        bloc: bloc,
                        farzWidget: farzWidget,
                      )),
                  }
                ],
              )),
        )
      ],
    );
  }
}
