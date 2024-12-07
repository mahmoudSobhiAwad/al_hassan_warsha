
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextWithCheckBox extends StatelessWidget {
  const CustomTextWithCheckBox({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: AppFontStyles.extraBoldNew16(context),
          ),
        ),
        const SizedBox(width: 10,),
        const IconButton(
            onPressed: null,
            icon: Icon(
                Icons.check_box_outline_blank_rounded)),
      ],
    );
  }
}

