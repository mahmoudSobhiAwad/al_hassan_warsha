import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/rotate_extension.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';
class SearchMenuInSearchBar extends StatelessWidget {
  const SearchMenuInSearchBar({
    super.key,
    required this.changeSearchType,
    required this.searchList,
    this.searchedKey = '',
    this.searchedStyle,
  });

  final void Function(SearchModel p1) changeSearchType;
  final List<SearchModel> searchList;
  final String searchedKey;
  final TextStyle?searchedStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5,top: 5,bottom: 5),
      decoration: BoxDecoration(
        boxShadow: [customLowBoxShadow()],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            searchedKey.isNotEmpty ? searchedKey : "البحث ب",
            style:searchedStyle?? AppFontStyles.extraBoldNew18(context),
          ),
          
          PopupMenuButton<SearchModel>(
              color: AppColors.veryLightGray,
              onSelected: (value) {
                changeSearchType(value);
              },
              constraints: const BoxConstraints(maxHeight: 350, maxWidth: 200),
              itemBuilder: (context) {
                return [
                  ...List.generate(
                      searchList.length,
                      (index) => PopupMenuItem(
                            value: searchList[index],
                            child: Center(
                                child: Text(
                              searchList[index].valueArSearh,
                              style: AppFontStyles.bold19(context),
                            )),
                          )),
                ];
              },
              icon: const Icon(Icons.arrow_back_ios).rotate(angle: 90))
        ],
      ),
    );
  }
}

