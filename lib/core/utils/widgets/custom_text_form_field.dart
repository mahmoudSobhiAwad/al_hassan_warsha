import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.maxLine,
      this.initialValue,
      this.validator,
      this.controller,
      this.textAlign,
      this.onChanged,
      this.enableFocusBorder = true,
      this.inputFormatters,
      this.textInputType,
      this.readOnly = false,
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
      this.textStyle,
      this.enableFill = true,
      this.onTap,
      this.contextMenuBuilder,
      this.fillColor});
  final Widget? labelWidget;
  final double? borderRadius;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
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
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final String? initialValue;
  final TextStyle? textStyle;
  final bool readOnly;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      contextMenuBuilder: contextMenuBuilder,
      readOnly: readOnly,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLine,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      cursorColor: Colors.black,
      onTap: onTap,
      style: textStyle ?? getAdaptiveFontStyle(context),
      decoration: InputDecoration(
        errorStyle: AppFontStyles.extraBoldNew14(context),
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

TextStyle getAdaptiveFontStyle(
  BuildContext context,
) {
  if (AppFontsLayout.isMobile(context)) {
    return AppFontStyles.bold12(context);
  } else if (AppFontsLayout.isTablet(context)) {
    return AppFontStyles.bold14(context);
  } else if (AppFontsLayout.isDesktop(context)) {
    return AppFontStyles.extraBoldNew16(context);
  } else {
    return AppFontStyles.meduim12(context); // Fallback
  }
}
