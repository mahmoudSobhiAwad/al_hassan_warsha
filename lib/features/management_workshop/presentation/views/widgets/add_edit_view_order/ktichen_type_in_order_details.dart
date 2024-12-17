import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';
class KitchenTypeInOrderDetails extends StatelessWidget {
  const KitchenTypeInOrderDetails({
    super.key,
    required this.orderModel,
    required this.changekitchenTypeValue,
    required this.allKitchenTypes,
    this.textStyle,
    required this.isReadOnly
  });

  final OrderModel orderModel;
  final void Function(String p1)? changekitchenTypeValue;
  final List<String> allKitchenTypes;
  final TextStyle?textStyle;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "نوع المطبخ ",
      enableBorder: true,
      onChanged: (value) {
        orderModel.kitchenType = value;
      },
      textStyle:textStyle?? AppFontStyles.extraBoldNew16(context),
      textLabel: "",
      readOnly:isReadOnly,
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
                                style: AppFontStyles.extraBoldNew16(context),
                              ),
                            ),
                          ))
                ];
              },
            )
          : null,
    );
  }
}
