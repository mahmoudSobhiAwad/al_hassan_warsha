import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_field_in_search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_menu_in_search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/table_creation/create_table_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarInManagment extends StatelessWidget {
  const SearchBarInManagment({
    super.key,
    required this.changeSearchType,
    required this.searchFunc,
    this.searchKeyWord,
    required this.changeSearchText,
    required this.searchList,
    required this.searchKey,
    this.enableCreateTable = true,
    this.textStyle,
  });

  final void Function(SearchModel) changeSearchType;
  final void Function(String) changeSearchText;
  final void Function() searchFunc;
  final SearchModel searchKey;
  final String? searchKeyWord;
  final List<SearchModel> searchList;
  final bool enableCreateTable;
  final TextStyle? textStyle;

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
                textStyle: textStyle,
                changeSearchText: changeSearchText,
                searchKeyWord: searchKeyWord,
                searchKey: searchKey,
                searchFunc: searchFunc),
          ),
        ),
        const Expanded(child: SizedBox()),
        SearchMenuInSearchBar(
            changeSearchType: changeSearchType, searchList: searchList,searchedStyle: textStyle,),
        const Expanded(child: SizedBox()),
        if (enableCreateTable)
          CustomPushContainerButton(
            pushButtomText: "إنشاء جدول",
            borderRadius: 12,
            color: AppColors.blueGray,
            iconSize: 30,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TableManager())),
            pushButtomTextFontSize: 18,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            iconBehind: FontAwesomeIcons.tableCells,
          ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
