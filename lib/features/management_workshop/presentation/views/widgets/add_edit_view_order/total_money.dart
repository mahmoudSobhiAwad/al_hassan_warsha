import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TotalMoneyInBillDetails extends StatelessWidget {
  const TotalMoneyInBillDetails({
    super.key,
    required this.changeStepsCounter,
    required this.enableController,
    required this.pillModel,
    required this.formKey,
    required this.onTapToChangeRemain,
  });

  final void Function(bool p1)? changeStepsCounter;
  final bool enableController;
  final PillModel pillModel;
  final GlobalKey<FormState>? formKey;
  final void Function()? onTapToChangeRemain;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "المبلغ الكلي",
      textLabel: "",
      readOnly: changeStepsCounter == null ? true : false,
      initalText: enableController ? null : pillModel.totalMoney,
      controller: enableController
          ? TextEditingController(text: pillModel.totalMoney)
          : null,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "المبلغ الكلي لا يمكن ان يكون خاليا ";
        }
        return null;
      },
      formKey: formKey,
      textInnerStyle:
          AppFontStyles.extraBoldNew20(context).copyWith(letterSpacing: 3),
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
        )
      ],
      onChanged: (value) {
        pillModel.totalMoney = value ?? "";
        onTapToChangeRemain != null ? onTapToChangeRemain!() : () {};
      },
      textStyle: AppFontStyles.extraBoldNew16(context),
      enableBorder: true,
      suffixIcon: Text(
        "جنية",
        style: AppFontStyles.extraBoldNew16(context),
      ),
    );
  }
}
