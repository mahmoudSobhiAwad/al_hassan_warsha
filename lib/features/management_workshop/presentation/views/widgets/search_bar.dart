import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/core/utils/widgets/rotate_extension.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class SearchBarInManagment extends StatelessWidget {
  const SearchBarInManagment(
      {super.key,
      this.enableLastIcon = true,
      required this.changeSearchType,
      required this.searchFunc,
      required this.changeSearchText,
      required this.searchKey});
  final bool enableLastIcon;
  final void Function(SearchModel) changeSearchType;
  final void Function(String) changeSearchText;
  final void Function() searchFunc;
  final SearchModel searchKey;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 10,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              customLowBoxShadow(),
            ]),
            child: CustomTextFormField(
              enableFill: true,
              enableFocusBorder: false,
              fillColor: Colors.white,
              borderRadius: 12,
              onChanged: changeSearchText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              labelWidget: Text(
                "ادخل بعض البيانات للبحث عن ........",
                style: AppFontStyles.extraBold18(context)
                    .copyWith(color: AppColors.lightGray2),
              ),
              suffixWidget: Row(
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
                            style: AppFontStyles.extraBold16(context),
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
                        color: AppColors.lightGray2,
                        size: 30,
                      )),
                ],
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [customLowBoxShadow()],
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                "البحث ب",
                style: AppFontStyles.extraBold20(context),
              ),
              const SizedBox(
                width: 10,
              ),
              PopupMenuButton<SearchModel>(
                  color: AppColors.veryLightGray,
                  onSelected: (value) {
                    changeSearchType(value);
                  },
                  constraints:
                      const BoxConstraints(maxHeight: 350, maxWidth: 200),
                  itemBuilder: (context) {
                    return [
                      ...List.generate(
                          searchList.length,
                          (index) => PopupMenuItem(
                                value: searchList[index],
                                child: Center(
                                    child: Text(
                                  searchList[index].valueArSearh,
                                  style: AppFontStyles.bold24(context),
                                )),
                              )),
                    ];
                  },
                  icon: const Icon(Icons.arrow_back_ios).rotate(angle: 90))
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        enableLastIcon
            ? const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.notifications,
                  size: 40,
                ))
            : const SizedBox(),
        const Expanded(flex: 2, child: SizedBox()),
      ],
    );
  }
}
