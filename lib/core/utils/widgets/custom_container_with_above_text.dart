import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomContainerWithTextAbove extends StatelessWidget {
  const CustomContainerWithTextAbove(
      {super.key,
      this.describtionInCont = "",
      this.textAbove = "",
      this.textStyleAbove,
      this.describeTextStyle});
  final String textAbove;
  final TextStyle? textStyleAbove;
  final TextStyle? describeTextStyle;
  final String describtionInCont;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAbove,
          style: textStyleAbove ?? AppFontStyles.extraBold24(context),
        ),
        Container(
          constraints: BoxConstraints(
              maxHeight: context.screenHeight * 0.125),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightGray2, width: 2),
          ),
          child: Align(
              alignment: Alignment.topRight,
              child: SingleChildScrollView(
                  child: SelectableText(
                describtionInCont,
                style:
                    describeTextStyle ?? AppFontStyles.extraBold24(context),
                maxLines: 2,
              ))),
        ),
      ],
    );
  }
}
