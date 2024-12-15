import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/upper_action_view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/add_order_view_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/nex_back_buttons.dart';
import 'package:flutter/material.dart';

class OrderViewInMobileLayout extends StatelessWidget {
  const OrderViewInMobileLayout({
    super.key,
    required this.orderModel,
    required this.bloc,
  });
  final OrderModel orderModel;
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: orderModel.orderName,
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 12,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UpperButtonsInViewOrder(
                fontSize: 14,
                edgeInsets:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                iconSize: 20,
                navToEdit: (m) {},
                onTapForCustomerProfileView: () {},
                orderModel: orderModel),
          ),
        ),
        Expanded(
          child: CustomPageViewInViewOrderMobile(
            orderModel: orderModel,
            isReadOnly: true,
            bloc: bloc,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        NextPageOrBackButtons(
          currPageIndex: bloc.currPageMobile,
          nextOrBack: (stauts) {
            bloc.add(ChangeCurrPageInMobile(isForward: stauts));
          },
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
