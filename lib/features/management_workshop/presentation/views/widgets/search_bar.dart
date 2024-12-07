import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_field_in_search_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_menu_in_search_bar.dart';
import 'package:flutter/material.dart';

class SearchBarInManagment extends StatelessWidget {
  const SearchBarInManagment(
      {super.key,
      required this.changeSearchType,
      required this.searchFunc,
      this.searchKeyWord,
      required this.changeSearchText,
      required this.searchList,
      required this.searchKey});

  final void Function(SearchModel) changeSearchType;
  final void Function(String) changeSearchText;
  final void Function() searchFunc;
  final SearchModel searchKey;
  final String? searchKeyWord;
  final List<SearchModel> searchList;

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
                changeSearchText: changeSearchText,
                searchKeyWord: searchKeyWord,
                searchKey: searchKey,
                searchFunc: searchFunc),
          ),
        ),
        const Expanded(child: SizedBox()),
        SearchMenuInSearchBar(
            changeSearchType: changeSearchType, searchList: searchList),
        const Expanded(flex: 2, child: SizedBox()),
      ],
    );
  }
}

