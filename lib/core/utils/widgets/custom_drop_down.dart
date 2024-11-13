
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomContainerWithDropDownList extends StatelessWidget {
  const CustomContainerWithDropDownList(
      {super.key, required this.primaryText, this.headerText});
  final String primaryText;
  final String? headerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText ?? "",
          style: AppFontStyles.extraBold18(context),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGray1, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Flexible(
                
                child: Text(
                  primaryText,
                  style: AppFontStyles.extraBold18(context),
                ),
              ),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.expand_more_rounded,
                    size: 30,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}