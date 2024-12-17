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
    this.isEdit = false,
    this.orderModel,
    required this.bottomOrderAction,
  });

  final ManagementBloc bloc;
  final CustomerModel? customerModel;
  final bool isEdit;
  final bool isReadOnly;
  final OrderModel? orderModel;
  final Widget bottomOrderAction;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      controller: isEdit
          ? bloc.pageControllerInMobileOrderForEditScreen
          : bloc.pageControllerInMobileOrder,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return [
          FirstPageInAddOrderInMobileLayout(
            isReadOnly: isReadOnly,
            orderModel: orderModel ?? bloc.orderModel,
            formKey: isEdit ? bloc.fromKeyFirstPageEdit : bloc.fromKeyFirstPage,
            colorModel: orderModel?.colorModel ?? bloc.colorModel,
            customerModel: orderModel?.customerModel ?? bloc.customerModel,
            onChangeNotice: (notice) {
              isEdit
                  ? orderModel?.notice = notice
                  : bloc.orderModel.notice = notice;
            },
            onChangeColorValue: (colorHex) {
              bloc.add(ChangeColorOfOrderEvent(
                  colorValue: colorHex, isEdit: isEdit));
            },
            onChangeDate: (date) {
              bloc.add(ChangeDateOfOrderEvent(dateTime: date, isEdit: isEdit));
            },
            allKitchenTypes: bloc.allKitchenTypes,
            onChangeKitchenType: (type) {
              bloc.add(
                  ChangeKitchenTypeEvent(kitchenType: type, isEdit: isEdit));
            },
          ),
          SecondPageInOrderMobile(
            enableClear: !isReadOnly,
            isReadOnly: isReadOnly,
            list: orderModel?.extraOrdersList ?? bloc.extraOrdersList,
            mediaOrderList: orderModel?.getPickedMedia() ?? bloc.mediaOrderList,
            addMedia: isReadOnly
                ? null
                : (list) {
                    bloc.add(AddMediaInAddOrder(list: list, isEdit: isEdit));
                  },
            addMoreExtras: isReadOnly
                ? null
                : () {
                    bloc.add(AddExtraInOrder(isEdit: isEdit));
                  },
            addMoreMedia: (items) {
              bloc.add(AddMediaInAddOrder(list: items, isEdit: isEdit));
            },
            removeItemFromExtras: (index) {
              bloc.add(RemoveExtraItem(index: index, isEdit: isEdit));
            },
            removeMedia: isReadOnly
                ? null
                : (index) {
                    bloc.add(RemoveMediItemEvent(index: index, isEdit: isEdit));
                  },
          ),
          ThirdPageInOrderMobile(
              pillModel: orderModel?.pillModel ?? bloc.pillModel,
              onTapToChangeRemain: () {
                bloc.add(ChangeRemainInAddOrderEvent(isEdit: isEdit));
              },
              enableController: isReadOnly,
              changeStepsCounter: (status) {
                bloc.add(ChangeCounterOfStepsInPillEvent(
                    increase: status, isEdit: isEdit));
              },
              onChangePayment: (payment) {
                bloc.add(ChangeOptionPaymentEvent(
                    paymentWay: payment, isEdit: isEdit));
              },
              formKey:
                  isEdit ? bloc.fromKeyThirdPageEdit : bloc.fromKeyThirdPage,
              actionButton: bottomOrderAction)
        ][index];
      },
    );
  }
}
