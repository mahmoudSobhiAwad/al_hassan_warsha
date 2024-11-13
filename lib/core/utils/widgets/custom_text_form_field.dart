import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.maxLine,
      this.enableFocusBorder=true,
      this.inputFormatters,
      this.textInputType,
      this.suffixText,
      this.suffixTextStyle,
      this.labelWidget,
      this.contentPadding,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.enableBorder = true,
      this.prefixWidget,
      this.suffixWidget,
      this.enableFill = true,
      this.fillColor});
  final Widget? labelWidget;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? fillColor;
  final bool enableBorder;
  final bool enableFill;
  final Widget? suffixWidget;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Widget? prefixWidget;
  final int? maxLine;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? contentPadding;
  final bool enableFocusBorder;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      cursorColor: Colors.black,
      style: AppFontStyles.extraBold18(context),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        focusColor: Colors.black,
        suffixIcon: suffixWidget,
        suffixText: suffixText,
        suffixStyle: suffixTextStyle,
        fillColor: fillColor,
        filled: enableFill,
        prefixIcon: prefixWidget,
        label: labelWidget,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: enableBorder
              ? BorderSide(
                  color: borderColor ?? AppColors.veryLightGray,
                  width: borderWidth ?? 0,
                )
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: enableBorder
              ? BorderSide(
                  color: borderColor ?? AppColors.veryLightGray,
                  width: borderWidth ?? 0,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          borderSide: enableFocusBorder
              ? const BorderSide(
                  color: AppColors.black,
                  width: 2,
                )
              : BorderSide.none,
        ),
        hoverColor: Colors.white,
      ),
    );
  }
}
