import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomColumnWithTextInAddNewType extends StatelessWidget {
  const CustomColumnWithTextInAddNewType(
      {super.key, required this.text, required this.textLabel});
  final String text;
  final String textLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppFontStyles.extraBold30(context),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextFormField(
          borderRadius: 12,
          enableBorder: false,
          fillColor: AppColors.white,
          labelWidget: Text(
            textLabel,
            style: AppFontStyles.extraBold18(context)
                .copyWith(color: AppColors.lightGray2),
          ),
        ),
      ],
    );
  }
}
