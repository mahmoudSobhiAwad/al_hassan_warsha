import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountToDowStepInCustomerBill extends StatelessWidget {
  const AmountToDowStepInCustomerBill({
    super.key,
    this.enableSuffix = true,
    required this.pillModel,
    this.textStyle,
  });
  final TextStyle? textStyle;

  final bool enableSuffix;
  final PillModel? pillModel;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textStyle: textStyle,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      fillColor: AppColors.white,
      enableFill: true,
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
        )
      ],
      validator: (value) {
        if (value == null || value == "0.0") {
          return "المبلغ لا يمكن ان يكون خاليا ";
        }
        return null;
      },
      borderRadius: 8,
      onChanged: (value) {
        pillModel?.steppedAmount = value;
      },
      borderWidth: 2,
      borderColor: AppColors.lightGray1,
      suffixWidget: enableSuffix
          ? Text(
              "جنية",
              style: AppFontStyles.extraBoldNew16(context),
            )
          : null,
      labelWidget: Text(
        "...................",
        style: AppFontStyles.meduim12(context)
            .copyWith(color: AppColors.lightGray2),
      ),
    );
  }
}
