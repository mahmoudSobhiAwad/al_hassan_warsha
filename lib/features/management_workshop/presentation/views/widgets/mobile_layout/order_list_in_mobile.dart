import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/order_item_in_mobile.dart';
import 'package:flutter/material.dart';

class OrderListInMobileManagement extends StatelessWidget {
  const OrderListInMobileManagement({
    super.key,
    required this.bloc,
    this.searchedList,
    this.insteadOfFilter,
  });

  final ManagementBloc bloc;
  final Widget? insteadOfFilter;
  final List<OrderModel>? searchedList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          insteadOfFilter ??
              FilterOrdersWithMonthYear(
                iconSize: 24,
                titleStyle: AppFontStyles.semiBold16(context),
                dateStyle: AppFontStyles.semiBold14(context),
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
            height: 15,
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: searchedList?.length ?? bloc.ordersList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return OrderItemInMobile(
                        orderModel:
                            searchedList?[index] ?? bloc.ordersList[index]);
                  })),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
