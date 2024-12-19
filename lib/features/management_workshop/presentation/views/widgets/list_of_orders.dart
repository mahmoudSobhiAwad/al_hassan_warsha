import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/one_order_item.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/pop_menu_action.dart';
import 'package:flutter/material.dart';

class ListOfOrder extends StatelessWidget {
  const ListOfOrder({super.key, required this.orderList, required this.bloc,this.enableAddress=true});
  final List<OrderModel> orderList;
  final ManagementBloc bloc;
  final bool enableAddress;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18, right: 10),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowOneOrderView(
                                      orderModel: orderList[index],
                                      bloc: bloc,
                                    )));
                      },
                      child: OneOrderItem(
                        enableAddress: enableAddress,
                        orderModel: orderList[index],
                      ))),
              const SizedBox(
                width: 14,
              ),
              PopMenuActionBehindEachOrder(
                orderList: orderList,
                bloc: bloc,
                currIndex: index,
              )
            ],
          ),
        );
      },
    );
  }
}
