import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_edit_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/expanded_divider.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/searched_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class ManagmentBody extends StatelessWidget {
  const ManagmentBody({
    super.key,
    required this.bloc,
  });

  final ManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
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
          )),
          Expanded(
            flex: 4,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    SearchBarInManagment(
                      changeSearchType: (text) {
                        bloc.add(ChangeSearchKeyEvent(searchKey: text));
                      },
                      searchFunc: () {
                        if (bloc.searchKeyWord.trim().isNotEmpty &&
                            bloc.searchKey.valueArSearh.isNotEmpty) {
                          bloc.add(SearchForOrderEvent(enable: true));
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
                      true => Builder(builder: (context) {
                          return Expanded(
                            child: SearchedOrderResutl(
                              searchKey: bloc.searchKeyWord,
                              bloc: bloc,
                              backToMain: () {
                                bloc.add(SearchForOrderEvent(enable: false));
                              },
                              searchedList: bloc.searchList,
                              isSearchLoading: bloc.isSearchLoading,
                            ),
                          );
                        }),
                      false => Expanded(
                            child: OrderListWithFilter(
                          bloc: bloc,
                        )),
                    }
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class OrderListWithFilter extends StatelessWidget {
  const OrderListWithFilter({
    super.key,
    required this.bloc,
  });

  final ManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterOrdersWithMonthYear(
          year: bloc.currentYear,
          month: bloc.currentMonth,
          changeMonth: (month) {
            bloc.add(ChangeCurrentMonthEvent(month: month));
          },
          changeYear: (time) {
            bloc.add(ChangeCurrentYearEvent(year: time.year));
            Navigator.pop(context);
          },
          searchFor: () {
            bloc.add(GetAllOrdersEvent());
          },
        ),
        const SizedBox(
          height: 12,
        ),
        const FullTableHeader(),
        const ExpandedDivider(),
        bloc.isLoadingAllOrders
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : bloc.categorizedList.isNotEmpty
                ? Expanded(
                    child: CustomScrollView(
                      slivers: [
                        ListOfOrder(
                          bloc: bloc,
                          orderList: bloc.categorizedList,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد طلبات لهذ الشهر",
                        style: AppFontStyles.extraBold50(context),
                      ),
                    ),
                  ),
        const SizedBox(
          height: 12,
        ),
        Center(
            child: CustomPushContainerButton(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditViewOrder(bloc: bloc)));
          },
          pushButtomText: "طلب جديد",
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          borderRadius: 12,
        )),
      ],
    );
  }
}
