import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextWithTheSameStyle extends StatelessWidget {
  const CustomTextWithTheSameStyle({
    super.key,
    required this.text,
    this.textStyle,
    this.letterSpacing,
    this.maxLine,
  });

  final String text;
  final TextStyle? textStyle;
  final double? letterSpacing;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    // Example adaptive text styles based on layout
    TextStyle adaptiveTextStyle;

    if (AppFontsLayout.isMobile(context)) {
      adaptiveTextStyle = AppFontStyles.meduim12(context);
    } else if (AppFontsLayout.isTablet(context)) {
      adaptiveTextStyle = AppFontStyles.bold10(context);
    } else if (AppFontsLayout.isDesktop(context)) {
      adaptiveTextStyle = AppFontStyles.extraBold14(context);
    } else {
      adaptiveTextStyle = AppFontStyles.meduim12(context); // Fallback
    }

    return Text(
      text,
      style: (textStyle ?? adaptiveTextStyle).copyWith(letterSpacing: letterSpacing),
      maxLines:maxLine?? 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}

