import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/get_color_for_order.dart';
import 'package:flutter/material.dart';

class RowOrderItems extends StatelessWidget {
  const RowOrderItems({
    super.key,
    required this.orderModel,
    required this.colorOrderModel,
    required this.changeColorValue,
    required this.changekitchenTypeValue,
    required this.changeDate,
  });

  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int p1) changeColorValue;
  final void Function(String p1) changekitchenTypeValue;
  final void Function(DateTime p1) changeDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: CustomColumnWithTextInAddNewType(
                text: "اسم المطبخ",
                onChanged: (value) {
                  orderModel.orderName = value ?? "";
                },
                enableBorder: true,
                textStyle: AppFontStyles.extraBold18(context),
                textLabel: "")),
        const Expanded(child: SizedBox()),
        GetColorForOrder(
            colorOrderModel: colorOrderModel,
            changeColorValue: changeColorValue),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              text: "نوع المطبخ ",
              enableBorder: true,
              onChanged: (value) {
                orderModel.kitchenType = value;
              },
              textStyle: AppFontStyles.extraBold18(context),
              textLabel: "",
              controller: TextEditingController(text: orderModel.kitchenType),
              suffixIcon: PopupMenuButton(
                onSelected: (value) {
                  changekitchenTypeValue(value);
                },
                color: AppColors.lightGray1,
                icon: const Icon(Icons.expand_more_outlined),
                itemBuilder: (BuildContext context) {
                  return [
                    ...List.generate(
                        5,
                        (index) => PopupMenuItem(
                              value: "$index",
                              child: Text("$index"),
                            ))
                  ];
                },
              ),
            )),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              controller: TextEditingController(
                  text: orderModel.recieveTime?.toString() ?? ""),
              text: " تاريخ الاستلام ",
              enableBorder: true,
              textStyle: AppFontStyles.extraBold18(context),
              textLabel: "",
              suffixIcon: IconButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1))
                      .then((value) {
                    if (value != null) {
                      changeDate(value);
                    }
                  });
                },
                icon: const Icon(Icons.calendar_month_rounded),
              ),
            )),
      ],
    );
  }
}
