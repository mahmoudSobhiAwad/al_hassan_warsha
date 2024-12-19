import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bottom_actions_in_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/upper_action_view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/get_contract.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/custom_page_view_list_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/nex_back_buttons.dart';
import 'package:flutter/material.dart';

class OrderViewInMobileLayout extends StatefulWidget {
  const OrderViewInMobileLayout({
    super.key,
    required this.orderModel,
    required this.bloc,
  });
  final OrderModel orderModel;
  final ManagementBloc bloc;

  @override
  State<OrderViewInMobileLayout> createState() =>
      _OrderViewInMobileLayoutState();
}

class _OrderViewInMobileLayoutState extends State<OrderViewInMobileLayout> {
  final PageController _pageController = PageController(keepPage: false);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: widget.orderModel.orderName,
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            widget.bloc.add(SetCurrPageIndexToZero());
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
              navToEdit: () {
                widget.bloc.add(NavToEditEvent(orderModel: widget.orderModel));
                widget.bloc.currPageMobile = 0;
                _pageController.jumpToPage(0);
              },
              onTapForCustomerProfileView: () {
                widget.bloc.add(GetCustomerProfileEvent(
                    customerId: widget.orderModel.customerId));
                widget.bloc.currPageMobile = 0;
                _pageController.jumpToPage(0);
              },
              getPdfContract: () async {
                await getPdfContract(widget.orderModel);
              },
            ),
          ),
        ),
        Expanded(
          child: CustomPageViewInViewOrderMobile(
            pageController: _pageController,
            orderModel: widget.orderModel,
            bottomOrderAction: BottomActionOrderInViewOrder(
                fontSize: 18,
                orderModel: widget.orderModel,
                markAsDone: (orderId, check) {
                  widget.bloc.add(MarkOrderAsDelievredEvent(
                      orderId: orderId, makeItDone: check));
                },
                deleteOrder: (orderId, list) {
                  widget.bloc
                      .add(DeleteOrderEvent(mediaList: list, orderId: orderId));
                },
                isLoading: widget.bloc.isLoadingActionsOrder),
            isReadOnly: true,
            bloc: widget.bloc,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        NextPageOrBackButtons(
          currPageIndex: widget.bloc.currPageMobile,
          nextOrBack: (stauts) {
            widget.bloc.add(ChangeCurrPageInMobile(
                isForward: stauts, controller: _pageController));
          },
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
