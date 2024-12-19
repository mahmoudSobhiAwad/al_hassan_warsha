import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/expanded_divider.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:flutter/material.dart';

class OrderListWithFilter extends StatelessWidget {
  const OrderListWithFilter({
    super.key,
    required this.bloc,
    this.farzWidget,
    this.enableAddress = true,
  });

  final ManagementBloc bloc;
  final Widget? farzWidget;
  final bool enableAddress;

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
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: FullTableHeader(
            farzWidget: farzWidget,
            enableAddress: enableAddress,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: ExpandedDivider(),
        ),
        bloc.isLoadingAllOrders
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : bloc.categorizedList.isNotEmpty
                ? Expanded(
                    child: Scrollbar(
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CustomScrollView(
                          scrollBehavior: const ScrollBehavior()
                              .copyWith(scrollbars: false),
                          primary: true,
                          slivers: [
                            ListOfOrder(
                              enableAddress: enableAddress,
                              bloc: bloc,
                              orderList: bloc.categorizedList,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد طلبات لهذ الشهر",
                        style: AppFontStyles.extraBoldNew38(context),
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
                    builder: (context) => AddOrderView(bloc: bloc)));
          },
          pushButtomText: "طلب جديد",
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          borderRadius: 12,
        )),
      ],
    );
  }
}
