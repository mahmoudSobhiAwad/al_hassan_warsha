import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerInfoInOrder extends StatelessWidget {
  const CustomerInfoInOrder({
    super.key,
    required this.model,
  });
  final CustomerModel model;
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
                      onChanged: (String? value) {
                        model.customerName = value ?? "";
                      },
                      textStyle: AppFontStyles.extraBold18(context),
                      enableBorder: true,
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
                      text: "عنوان المنزل",
                      textLabel: "")),
            ],
          ),
        ),
      ],
    );
  }
}
