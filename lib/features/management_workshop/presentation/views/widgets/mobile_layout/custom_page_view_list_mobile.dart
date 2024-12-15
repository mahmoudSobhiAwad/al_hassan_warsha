import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/first_page_in_order_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/second_page_in_order_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/third_page_in_order_mobile.dart';
import 'package:flutter/material.dart';

class CustomPageViewInViewOrderMobile extends StatelessWidget {
  const CustomPageViewInViewOrderMobile({
    super.key,
    required this.bloc,
    this.customerModel,
    this.isReadOnly = false,
    this.orderModel,
    required this.bottomOrderAction,
  });

  final ManagementBloc bloc;
  final CustomerModel? customerModel;
  final bool isReadOnly;
  final OrderModel? orderModel;
  final Widget bottomOrderAction;
  @override
  Widget build(BuildContext context) {
    return PageView(
      
      controller: bloc.pageControllerInMobileOrder,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        FirstPageInAddOrderInMobileLayout(
          isReadOnly: isReadOnly,
          orderModel: orderModel ?? bloc.orderModel,
          formKey: bloc.fromKey,
          colorModel: orderModel?.colorModel ?? bloc.colorModel,
          customerModel: orderModel?.customerModel ?? bloc.customerModel,
          onChangeNotice: (notice) {
            bloc.orderModel.notice = notice;
          },
          onChangeColorValue: (colorHex) {
            bloc.add(ChangeColorOfOrderEvent(colorValue: colorHex));
          },
          onChangeDate: (date) {
            bloc.add(ChangeDateOfOrderEvent(dateTime: date));
          },
          allKitchenTypes: bloc.allKitchenTypes,
          onChangeKitchenType: (type) {
            bloc.add(ChangeKitchenTypeEvent(kitchenType: type));
          },
        ),
        SecondPageInOrderMobile(
          enableClear: !isReadOnly,
          list: orderModel?.extraOrdersList ?? bloc.extraOrdersList,
          mediaOrderList: orderModel?.getPickedMedia() ?? bloc.mediaOrderList,
          addMedia: (list) {
            bloc.add(AddMediaInAddOrder(list: list));
          },
          addMoreExtras: () {
            bloc.add(AddExtraInOrder());
          },
          addMoreMedia: (items) {
            bloc.add(AddMediaInAddOrder(list: items));
          },
          removeItemFromExtras: (index) {
            bloc.add(RemoveExtraItem(index: index));
          },
          removeMedia: (index) {
            bloc.add(RemoveMediItemEvent(index: index));
          },
        ),
        ThirdPageInOrderMobile(
          pillModel: orderModel?.pillModel ?? bloc.pillModel,
          onTapToChangeRemain: () {
            bloc.add(ChangeRemainInAddOrderEvent());
          },
          enableController: isReadOnly,
          changeStepsCounter: (status) {
            bloc.add(ChangeCounterOfStepsInPillEvent(increase: status));
          },
          onChangePayment: (payment) {
            bloc.add(ChangeOptionPaymentEvent(paymentWay: payment));
          },
          formKey: bloc.fromKey,
          actionButton: bottomOrderAction
        )
      ],
    );
  }
}

