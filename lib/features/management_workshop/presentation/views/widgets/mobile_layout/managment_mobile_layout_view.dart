import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/order_list_in_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/search_bar_mobile.dart';
import 'package:flutter/material.dart';

class ManagmentMobileView extends StatelessWidget {
  const ManagmentMobileView({super.key, required this.bloc});
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    //TODO:add on change function on bloc to track change in search keyword!
    return Column(
      children: [
        const CustomMobileAppBar(
          title: "إدراة الورشة",
          enableDrawer: false,
        ),
        const SizedBox(
          height: 10,
        ),
        SearchBarInMobileManagement(
          searchKeyWord: bloc.searchKeyWord,
          searchKey: bloc.searchKey,
          enableSearch: () {
            bloc.add(SearchForOrderEvent(enable: true));
          },
          changeSearchKeyWord: (keyWord) {
            bloc.searchKeyWord = keyWord;
          },
          changeSearchKey: (searchKey) {
            bloc.add(ChangeSearchKeyEvent(searchKey: searchKey));
          },
        ),
        const SizedBox(
          height: 15,
        ),
        switch (bloc.enableSearchMode) {
          true => OrderListInMobileManagement(
              bloc: bloc,
              searchedList: bloc.searchList,
              insteadOfFilter: Row(
                children: [
                  Text(
                    "نتائج البحث الخاصة ب ",
                    style: AppFontStyles.semiBold16(context),
                  ),
                  Flexible(
                    child: Text(
                      bloc.searchKeyWord,
                      style: AppFontStyles.semiBold14(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        bloc.add(SearchForOrderEvent(enable: false));
                      },
                      child: Text("العودة للرئيسية",
                          style: AppFontStyles.bold18(context).copyWith(
                            color: AppColors.blue,
                          )))
                ],
              ),
            ),
          false => OrderListInMobileManagement(bloc: bloc),
        },
        Center(
            child: CustomPushContainerButton(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddOrderView(bloc: bloc)));
          },
          pushButtomText: "طلب جديد",
          pushButtomTextFontSize: 16,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          borderRadius: 10,
        )),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
