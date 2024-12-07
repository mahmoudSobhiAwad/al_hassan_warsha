import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_field_in_search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_menu_in_search_bar.dart';
import 'package:flutter/material.dart';

class SearchBarInMobileManagement extends StatelessWidget {
  const SearchBarInMobileManagement({
    super.key,
    required this.bloc,
  });

  final ManagementBloc bloc;

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
              textStyle: AppFontStyles.bold12(context),
              searchFunc: () {
                if (bloc.searchKeyWord.trim().isNotEmpty &&
                    bloc.searchKey.valueArSearh.isNotEmpty) {
                  bloc.add(SearchForOrderEvent(enable: true));
                } else {
                  showCustomSnackBar(
                      context, "حدد كلمة البحث او نوع البحث ",
                      backgroundColor: AppColors.orange);
                }
              },
              searchKeyWord: bloc.searchKeyWord,
              searchKey: bloc.searchKey,
              changeSearchText: (text) {
                bloc.searchKeyWord = text;
              },
              enableSuffiex: false,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        SearchMenuInSearchBar(
          searchedStyle: AppFontStyles.bold12(context),
          searchedKey: bloc.searchKey.valueArSearh,
          searchList: searchListInOrders,
          changeSearchType: (text) {
            bloc.add(ChangeSearchKeyEvent(searchKey: text));
          },
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
