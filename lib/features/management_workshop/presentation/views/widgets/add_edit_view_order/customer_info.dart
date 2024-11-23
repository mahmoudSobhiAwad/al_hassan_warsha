import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerInfoInOrder extends StatelessWidget {
  const CustomerInfoInOrder({
    super.key,
    required this.model,
    this.formKey,
    this.isReadOnly = false,
  });
  final CustomerModel model;
  final GlobalKey<FormState>? formKey;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "بيانات العميل",
          style: AppFontStyles.extraBold24(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CustomColumnWithTextInAddNewType(
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
                      controller:
                          TextEditingController(text: model.customerName ?? ""),
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
                      readOnly: isReadOnly,
                      text: "اسم العميل",
                      textLabel: "")),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                      onChanged: (String? value) {
                        model.phone = value ?? "";
                      },
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
                      readOnly: isReadOnly,
                      controller:
                          TextEditingController(text: model.phone ?? ""),
                      text: "رقم الهاتف",
                      textLabel: "")),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                      onChanged: (String? value) {
                        model.secondPhone = value ?? "";
                      },
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
                      readOnly: isReadOnly,
                      controller:
                          TextEditingController(text: model.secondPhone ?? ""),
                      text: "رقم هاتف احتياطي ",
                      textLabel: "")),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                      onChanged: (String? value) {
                        model.homeAddress = value ?? "";
                      },
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
                      readOnly: isReadOnly,
                      controller:
                          TextEditingController(text: model.homeAddress ?? ""),
                      text: "عنوان المنزل",
                      textLabel: "")),
            ],
          ),
        ),
      ],
    );
  }
}
