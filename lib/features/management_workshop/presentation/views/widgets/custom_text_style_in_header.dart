import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextWithTheSameStyle extends StatelessWidget {
  const CustomTextWithTheSameStyle({
    super.key,
    required this.text,
    this.textStyle,
    this.letterSpacing,
  });
  final String text;
  final TextStyle?textStyle;
  final double? letterSpacing;
  

  @override
  Widget build(BuildContext context) {
    return Text(text,style:textStyle?? AppFontStyles.extraBold14(context).copyWith(letterSpacing: letterSpacing),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,);
  }
}