import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_phone.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/home_address.dart';
import 'package:flutter/material.dart';

class CustomerInfoInOrderInTablet extends StatelessWidget {
  const CustomerInfoInOrderInTablet({
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
          style: AppFontStyles.bold18(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 5,
                  child: CustomerNameInOrder(
                    formKey: formKey,
                    model: model,
                    isReadOnly: isReadOnly,
                    textStyle: AppFontStyles.bold16(context),
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: NumberPhoneInOrder(
                    model: model,
                    isReadOnly: isReadOnly,
                    textStyle: AppFontStyles.bold16(context),
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: SecondPhoneInOrder(
                    model: model,
                    isReadOnly: isReadOnly,
                    textStyle: AppFontStyles.bold16(context),
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 4,
                  child: HomeAddressInOrder(
                    model: model,
                    isReadOnly: isReadOnly,
                    textStyle: AppFontStyles.bold16(context),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

