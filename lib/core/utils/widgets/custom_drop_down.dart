import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';

class CustomContainerWithDropDownList extends StatelessWidget {
  const CustomContainerWithDropDownList(
      {super.key,
      required this.primaryText,
      this.headerText,
      this.onSelected,
      this.headerStyle,
      this.enableDropDwon=true,
      this.dropDownList = const []});
  final String primaryText;
  final String? headerText;
  final TextStyle?headerStyle;
  final void Function(SearchModel)? onSelected;
  final List<SearchModel> dropDownList;
  final bool enableDropDwon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText ?? "",
          style:headerStyle?? AppFontStyles.extraBoldNew16(context),
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
                  style: AppFontStyles.extraBoldNew16(context),
                ),
              ),
            enableDropDwon?  PopupMenuButton(
                  color: AppColors.veryLightGray,
                  onSelected: onSelected,
                  itemBuilder: (context) {
                    return [
                      ...List.generate(dropDownList.length, (index) {
                        return PopupMenuItem(
                          value: dropDownList[index],
                          child: Text(dropDownList[index].valueArSearh,style: AppFontStyles.extraBoldNew16(context),),
                        );
                      })
                    ];
                  },
                  icon: const Icon(
                    Icons.expand_more_rounded,
                    size: 30,
                  )):const IconButton(onPressed: null,icon: Icon(Icons.hourglass_empty_rounded,color: AppColors.white,),),
            ],
          ),
        ),
      ],
    );
  }
}
