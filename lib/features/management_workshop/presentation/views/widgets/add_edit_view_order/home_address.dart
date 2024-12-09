import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class HomeAddressInOrder extends StatelessWidget {
  const HomeAddressInOrder({
    super.key,
    required this.model,
    required this.isReadOnly,
    this.textStyle,
  });

  final CustomerModel model;
  final bool isReadOnly;
  final TextStyle?textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
        onChanged: (String? value) {
          model.homeAddress = value ?? "";
        },
        textStyle: AppFontStyles.extraBoldNew16(context),
        enableBorder: true,
        readOnly: isReadOnly,
        initalText: model.homeAddress ?? "",
        text: "عنوان المنزل",
        textLabel: "");
  }
}
