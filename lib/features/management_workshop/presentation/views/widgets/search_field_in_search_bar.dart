import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';
class SearchFieldInSearchBar extends StatelessWidget {
  const SearchFieldInSearchBar({
    super.key,
    required this.changeSearchText,
    required this.searchKeyWord,
    required this.searchKey,
    required this.searchFunc,
    this.enableSuffiex = true,
    this.textStyle,
  });

  final void Function(String p1) changeSearchText;
  final String? searchKeyWord;
  final SearchModel searchKey;
  final void Function() searchFunc;
  final bool enableSuffiex;
  final TextStyle?textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      enableFill: true,
      enableFocusBorder: false,
      fillColor: Colors.white,
      borderRadius: 12,
      textStyle: textStyle,
      onChanged: changeSearchText,
      controller: TextEditingController(text: searchKeyWord),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      labelWidget: Text(
        "ادخل بعض البيانات للبحث عن ........",
        style:AppFontStyles.extraBoldNew16(context)
            .copyWith(color: AppColors.lightGray2,fontSize: textStyle?.fontSize),
      ),
      suffixWidget: enableSuffiex
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                searchKey.valueEnSearh.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightGray1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          searchKey.valueArSearh,
                          style: AppFontStyles.extraBoldNew14(context),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: searchFunc,
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
              ],
            )
          : IconButton(
              onPressed: searchFunc,
              icon: const Icon(
                Icons.search,
                size: 30,
              )),
    );
  }
}
