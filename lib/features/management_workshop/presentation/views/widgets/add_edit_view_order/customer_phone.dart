import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:flutter/material.dart';
class SecondPhoneInOrder extends StatelessWidget {
  const SecondPhoneInOrder({
    super.key,
    required this.model,
    required this.isReadOnly,
    this.textStyle,
  });

  final CustomerModel model;
  final TextStyle?textStyle;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
        onChanged: (String? value) {
          model.secondPhone = value ?? "";
        },
        textStyle:textStyle?? AppFontStyles.extraBoldNew16(context),
        enableBorder: true,
        readOnly: isReadOnly,
        initalText: model.secondPhone ?? "",
        text: "رقم هاتف احتياطي ",
        textLabel: "");
  }
}


class NumberPhoneInOrder extends StatelessWidget {
  const NumberPhoneInOrder({
    super.key,
    required this.model,
    required this.isReadOnly,
    this.textStyle
  });

  final CustomerModel model;
  final TextStyle?textStyle;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
        onChanged: (String? value) {
          model.phone = value ?? "";
        },
        
        textStyle:textStyle?? AppFontStyles.extraBoldNew16(context),
        enableBorder: true,
        readOnly: isReadOnly,
        initalText: model.phone ?? "",
        text: "رقم الهاتف",
        textLabel: "");
  }
}
