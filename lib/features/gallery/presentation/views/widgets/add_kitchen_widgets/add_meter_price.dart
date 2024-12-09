import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMeterPrice extends StatelessWidget {
  const AddMeterPrice({super.key,required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          "سعر المتر",
          style: AppFontStyles.extraBoldNew30(context),
        ),
        const Spacer(),
        const Spacer(),
        SizedBox(
            width: width * 0.25,
            child: CustomTextFormField(
              fillColor: AppColors.white,
              borderRadius: 12,
              borderColor: AppColors.lightGray2,
              labelWidget: Center(
                child: Text(
                  "............... جنية",
                  style: AppFontStyles.bold18(context)
                      .copyWith(color: AppColors.veryLightGray),
                ),
              ),
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
            )),
        const Spacer(),
      ],
    );
  }
}
