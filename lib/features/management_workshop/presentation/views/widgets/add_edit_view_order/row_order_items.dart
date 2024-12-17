import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/get_color_for_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/ktichen_type_in_order_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/order_name_in_details.dart';
import 'package:flutter/material.dart';

class RowOrderItems extends StatelessWidget {
  const RowOrderItems({
    super.key,
    required this.orderModel,
    required this.colorOrderModel,
    this.changeColorValue,
    this.changekitchenTypeValue,
    this.changeDate,
    this.aboveTextStyle,
    this.showKitchenName = true,
    this.formKey,
    this.allKitchenTypes = const [],
    required this.isReadOnly,
  });

  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int)? changeColorValue;
  final void Function(String)? changekitchenTypeValue;
  final void Function(DateTime)? changeDate;
  final GlobalKey<FormState>? formKey;
  final List<String> allKitchenTypes;
  final bool showKitchenName;
  final TextStyle? aboveTextStyle;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showKitchenName
            ? Expanded(
                flex: 3,
                child: OrderNameInOrderDetails(
                  isReadOnly: isReadOnly,
                    formKey: formKey, orderModel: orderModel))
            : const SizedBox(),
        showKitchenName ? const Expanded(child: SizedBox()) : const SizedBox(),
        Expanded(
          flex: 2,
          child: GetColorForOrder(
              colorOrderModel: colorOrderModel,
              changeColorValue: changeColorValue),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: KitchenTypeInOrderDetails(
                orderModel: orderModel,
                isReadOnly: isReadOnly,
                changekitchenTypeValue: changekitchenTypeValue,
                allKitchenTypes: allKitchenTypes)),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomDatePicker(
                formKey: formKey,
                recieveTime: orderModel.recieveTime,
                changeDate: changeDate)),
      ],
    );
  }
}
