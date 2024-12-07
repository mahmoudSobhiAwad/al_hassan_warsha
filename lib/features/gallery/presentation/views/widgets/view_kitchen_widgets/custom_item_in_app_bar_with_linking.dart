import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
class CustomItemInCustomLinkingAppBar extends StatelessWidget {
  const CustomItemInCustomLinkingAppBar(
      {super.key, required this.text, this.isLast = false,this.enableColor=true,this.fontSize});
  final String text;
  final bool isLast;
  final bool enableColor;
  final double ? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.screenWidth * 0.2,
          ),
          child: Text(
            text,
            style: AppFontStyles.extraBold40(context)
                .copyWith(fontSize: fontSize,color: enableColor ? AppColors.white : AppColors.black,),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        isLast
            ?  IconButton(
                onPressed: null,
                icon: Icon(
                  color: enableColor ? AppColors.white : AppColors.black,
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                ))
            : const SizedBox(),
      ],
    );
  }
}
