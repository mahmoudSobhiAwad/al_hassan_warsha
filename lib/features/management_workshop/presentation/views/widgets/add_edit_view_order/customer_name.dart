import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerNameInOrder extends StatelessWidget {
  const CustomerNameInOrder({
    super.key,
    this.formKey,
    required this.model,
    required this.isReadOnly,
    this.textStyle,
  });

  final GlobalKey<FormState>? formKey;
  final CustomerModel model;
  final bool isReadOnly;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
        formKey: formKey,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "اسم العميل  لا يمكن ان يكون خاليا ";
          }
          return null;
        },
        onChanged: (String? value) {
          model.customerName = value ?? "";
        },
        initalText: model.customerName,
        textStyle: textStyle ?? AppFontStyles.extraBoldNew16(context),
        enableBorder: true,
        readOnly: isReadOnly,
        text: "اسم العميل",
        textLabel: "");
  }
}
