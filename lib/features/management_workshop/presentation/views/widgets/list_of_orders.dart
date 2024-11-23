import 'package:al_hassan_warsha/features/gallery/presentation/manager/view_edit_add_bloc/bloc/view_edit_add_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/one_order_item.dart';
import 'package:flutter/material.dart';

class ListOfOrder extends StatelessWidget {
  const ListOfOrder({super.key, required this.orderList,required this.bloc});
  final List<OrderModel> orderList;
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowOneOrderView(orderModel: orderList[index],bloc:bloc ,)));
                      },
                      child: OneOrderItem(
                        orderModel: orderList[index],
                      ))),
              const SizedBox(
                width: 14,
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        );
      },
    );
  }
}
