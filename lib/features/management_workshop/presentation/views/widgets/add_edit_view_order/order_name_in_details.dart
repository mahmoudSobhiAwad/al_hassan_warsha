import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart'; 
class OrderNameInOrderDetails extends StatelessWidget {
  const OrderNameInOrderDetails({
    super.key,
    required this.formKey,
    required this.orderModel,
    this.textStyle,
    required this.isReadOnly,
  });

  final GlobalKey<FormState>? formKey;
  final OrderModel orderModel;
  final TextStyle?textStyle;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
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
        readOnly: isReadOnly,
        controller: TextEditingController(text: orderModel.orderName),
        textStyle:textStyle?? AppFontStyles.extraBoldNew16(context),
        textLabel: "");
  }
}
