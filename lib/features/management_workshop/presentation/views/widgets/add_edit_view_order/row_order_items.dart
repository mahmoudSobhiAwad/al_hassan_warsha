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
    this.changeColorValue,
    this.changekitchenTypeValue,
    this.changeDate,
    this.formKey,
  });

  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int p1)? changeColorValue;
  final void Function(String p1)? changekitchenTypeValue;
  final void Function(DateTime p1)? changeDate;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: CustomColumnWithTextInAddNewType(
                formKey: formKey,
                text: "اسم الطلب",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "اسم الطلب لا يمكن ان يكون خاليا ";
                  }
                  return null;
                },
                onChanged: (value) {
                  orderModel.orderName = value ?? "";
                },
                enableBorder: true,
                readOnly: formKey == null ? true : false,
                controller: TextEditingController(text: orderModel.orderName),
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
              readOnly: formKey == null ? true : false,
              controller: TextEditingController(text: orderModel.kitchenType),
              suffixIcon: changekitchenTypeValue != null
                  ? PopupMenuButton(
                      onSelected: (value) {
                        changekitchenTypeValue!(value);
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
                    )
                  : null,
            )),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              formKey: formKey,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "تاريخ الاستلام لا يمكن ان يكون خاليا ";
                }
                return null;
              },
              controller: TextEditingController(
                  text: orderModel.recieveTime?.toString() ?? ""),
              text: " تاريخ الاستلام ",
              enableBorder: true,
              readOnly: true,
              textStyle: AppFontStyles.extraBold18(context),
              textLabel: "",
              suffixIcon: IconButton(
                onPressed: () {
                  changeDate != null
                      ? showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1))
                          .then((value) {
                          if (value != null) {
                            changeDate!(value);
                          }
                        })
                      : null;
                },
                icon: const Icon(Icons.calendar_month_rounded),
              ),
            )),
      ],
    );
  }
}
