import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/get_color_for_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/ktichen_type_in_order_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/order_name_in_details.dart';
import 'package:flutter/material.dart';

class OrderDetailsInTablet extends StatelessWidget {
  const OrderDetailsInTablet({
    super.key,
    required this.orderModel,
    required this.colorOrderModel,
    this.changeColorValue,
    this.changekitchenTypeValue,
    this.changeDate,
    this.aboveTextStyle,
    this.formKey,
    this.allKitchenTypes = const [],
  });
  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int)? changeColorValue;
  final void Function(String)? changekitchenTypeValue;
  final void Function(DateTime)? changeDate;
  final GlobalKey<FormState>? formKey;
  final List<String> allKitchenTypes;
  final TextStyle? aboveTextStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تفاصيل الطلب",
          style: AppFontStyles.bold18(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: OrderNameInOrderDetails(
                      formKey: formKey, orderModel: orderModel)),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 4,
                child: GetColorForOrder(
                    label: "حدد اللون",
                    colorOrderModel: colorOrderModel,
                    changeColorValue: changeColorValue),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 4,
                  child: KitchenTypeInOrderDetails(
                      orderModel: orderModel,
                      formKey: formKey,
                      changekitchenTypeValue: changekitchenTypeValue,
                      allKitchenTypes: allKitchenTypes)),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 4,
                  child: CustomDatePicker(
                      textInnerStyle: AppFontStyles.regular14(context)
                          .copyWith(fontSize: 14),
                      aboveTextStyle: AppFontStyles.bold16(context),
                      formKey: formKey,
                      recieveTime: orderModel.recieveTime,
                      changeDate: changeDate)),
            ],
          ),
        ),
      ],
    );
  }
}

