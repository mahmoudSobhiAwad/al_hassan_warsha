import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_field_in_search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_menu_in_search_bar.dart';
import 'package:flutter/material.dart';

class SearchBarInMobileManagement extends StatelessWidget {
  const SearchBarInMobileManagement({
    super.key,
    required this.searchKey,
    required this.enableSearch,
    required this.searchTextController,
    required this.changeSearchKey,
    this.searchedList,
  });

  final SearchModel searchKey;
  final void Function() enableSearch;
  final void Function(SearchModel) changeSearchKey;
  final TextEditingController searchTextController;
  final List<SearchModel>?searchedList;
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
            child: SearchFieldInSearchBar(
              textEditingController: searchTextController,
              textStyle: AppFontStyles.bold12(context),
              searchFunc: () {
                if (searchTextController.text.trim().isNotEmpty &&
                    searchKey.valueArSearh.isNotEmpty) {
                  enableSearch();
                } else {
                  showCustomSnackBar(context, "حدد كلمة البحث او نوع البحث ",
                      backgroundColor: AppColors.orange);
                }
              },
              searchKey: searchKey,
              enableSuffiex: false,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        SearchMenuInSearchBar(
          searchedStyle: AppFontStyles.bold12(context),
          searchedKey: searchKey.valueArSearh,
          searchList:searchedList?? searchListInOrders,
          changeSearchType: (text) {
            changeSearchKey(text);
          },
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
