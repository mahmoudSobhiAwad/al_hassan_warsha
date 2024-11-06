import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,this.labelWidget,this.borderColor,this.borderRadius,this.borderWidth,this.enableBorder=true,this.prefixWidget,this.suffixWidget,this.enableFill=true,this.fillColor});
  final Widget?labelWidget;
  final double?borderRadius;
  final double?borderWidth;
  final Color?borderColor;
  final Color?fillColor;
  final bool enableBorder;
  final bool enableFill;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      style: AppFontStyles.extraBold18(context),
      decoration: InputDecoration(  
        focusColor: Colors.black,
        suffixIcon:suffixWidget,
        fillColor: fillColor,
        filled: enableFill,
        prefix: prefixWidget,
        label:labelWidget,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??0),
          borderSide:enableBorder? BorderSide(
            color:borderColor??AppColors.veryLightGray,
            width: borderWidth??0,):BorderSide.none,
        ),
        hoverColor: Colors.white,

      ),
    );
  }
}