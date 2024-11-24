import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_edit_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/expanded_divider.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
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
          const Expanded(child: SideBarManagement()),
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
                    const SearchBarInManagment(),
                    const SizedBox(
                      height: 24,
                    ),
                    const FilterOrdersWithMonthYear(),
                    const SizedBox(
                      height: 12,
                    ),
                    const FullTableHeader(),
                    const ExpandedDivider(),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          ListOfOrder(
                            bloc: bloc,
                            orderList: bloc.ordersList,
                          ),
                        ],
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
                                builder: (context) =>
                                    AddEditViewOrder(bloc: bloc)));
                      },
                      pushButtomText: "طلب جديد",
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      borderRadius: 12,
                    )),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
