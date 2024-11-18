import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomColumnWithTextInAddNewType extends StatelessWidget {
  const CustomColumnWithTextInAddNewType(
      {super.key, required this.text, this.validator,this.onChanged,this.formKey,this.prefixIcon,this.controller,this.borderWidth,this.suffixText,required this.textLabel,this.textStyle,this.maxLine,this.enableBorder=false,this.suffixIcon});
  final String text;
  final int?maxLine;
  final TextStyle?textStyle;
  final String textLabel;
  final String ?suffixText;
  final bool enableBorder;
  final Widget?suffixIcon;
  final Widget?prefixIcon;
  final double?borderWidth;
  final TextEditingController?controller;
  final GlobalKey<FormState>?formKey;
  final String? Function(String?v) ? validator;
  final void Function(String?v) ? onChanged;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: textStyle?? AppFontStyles.extraBold30(context),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextFormField(
          
          onChanged: onChanged,
          validator: validator,
          prefixWidget: prefixIcon,
          suffixWidget: suffixIcon,
          maxLine: maxLine,
          controller: controller,
          borderRadius: 12,
          suffixText: suffixText,
          enableBorder: enableBorder,
          borderColor: AppColors.lightGray2,
          borderWidth:borderWidth?? 1,
          fillColor: AppColors.white,
          labelWidget: Text(
            textLabel,
            maxLines: 1,
            style: AppFontStyles.extraBold18(context)
                .copyWith(color: AppColors.lightGray2,),
          ),
        ),
      ],
    );
  }
}
