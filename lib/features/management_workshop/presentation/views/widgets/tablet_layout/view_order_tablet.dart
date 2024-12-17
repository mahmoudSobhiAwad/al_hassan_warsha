import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bottom_actions_in_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/upper_action_view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/get_contract.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/add_order_body_tablet.dart';
import 'package:flutter/material.dart';

class ViewOrderTablet extends StatelessWidget {
  const ViewOrderTablet({super.key, required this.bloc, required this.model});
  final ManagementBloc bloc;
  final OrderModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWithLinking(
          items: ["إدارة الورشة", (model.orderName)],
          fontSize: 22,
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: UpperButtonsInViewOrder(
            fontSize: 18,
            edgeInsets: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            navToEdit: () {
              bloc.add(NavToEditEvent(orderModel: model));
            },
            getPdfContract: () async {
              await getPdfContract(model);
            },
            onTapForCustomerProfileView: () {
              //navToProfileView(orderModel.customerId);
            },
          ),
        ),
        CustomOrderBodyTablet(
          bottomActionWidget: BottomActionOrderInViewOrder(
              orderModel: model,
              markAsDone: (orderId, check) {
                bloc.add(MarkOrderAsDelievredEvent(
                    orderId: orderId, makeItDone: check));
              },
              deleteOrder: (orderId, list) {
                bloc.add(DeleteOrderEvent(mediaList: list, orderId: orderId));
              },
              isLoading: bloc.isLoadingActionsOrder),
          bloc: bloc,
          isReadOnly: true,
          orderModel: model,
        ),
      ],
    );
  }
}
