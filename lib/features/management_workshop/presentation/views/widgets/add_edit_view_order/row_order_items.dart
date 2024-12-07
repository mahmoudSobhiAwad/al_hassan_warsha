import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
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
    this.showKitchenName = true,
    this.formKey,
    this.allKitchenTypes = const [],
  });

  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int p1)? changeColorValue;
  final void Function(String p1)? changekitchenTypeValue;
  final void Function(DateTime p1)? changeDate;
  final GlobalKey<FormState>? formKey;
  final List<String> allKitchenTypes;
  final bool showKitchenName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showKitchenName
            ? Expanded(
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
                    controller:
                        TextEditingController(text: orderModel.orderName),
                    textStyle: AppFontStyles.extraBoldNew16(context),
                    textLabel: ""))
            : const SizedBox(),
       showKitchenName ?const Expanded(child: SizedBox()):const SizedBox(),
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
              textStyle: AppFontStyles.extraBoldNew16(context),
              textLabel: "",
              readOnly: formKey == null ? true : false,
              controller: TextEditingController(text: orderModel.kitchenType),
              suffixIcon: changekitchenTypeValue != null
                  ? PopupMenuButton(
                      onSelected: (value) {
                        changekitchenTypeValue!(value);
                      },
                      constraints: const BoxConstraints(maxHeight: 350),
                      color: AppColors.veryLightGray,
                      icon: const Icon(Icons.expand_more_outlined),
                      itemBuilder: (BuildContext context) {
                        return [
                          ...List.generate(
                              allKitchenTypes.length,
                              (index) => PopupMenuItem(
                                    value: allKitchenTypes[index],
                                    child: Center(
                                      child: Text(
                                        allKitchenTypes[index],
                                        style:
                                            AppFontStyles.extraBoldNew16(context),
                                      ),
                                    ),
                                  ))
                        ];
                      },
                    )
                  : null,
            )),
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
