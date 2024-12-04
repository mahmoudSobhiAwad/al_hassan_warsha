import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_edit_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/expanded_divider.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:flutter/material.dart';

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
        const Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: FullTableHeader(),
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
                      radius: const Radius.circular(5),
                      thickness: 12,
                      thumbVisibility: true,
                      trackVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(scrollbars: false),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CustomScrollView(
                            primary: true,
                            slivers: [
                              ListOfOrder(
                                bloc: bloc,
                                orderList: bloc.categorizedList,
                              ),
                            ],
                          ),
                        ),
                      ),
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
