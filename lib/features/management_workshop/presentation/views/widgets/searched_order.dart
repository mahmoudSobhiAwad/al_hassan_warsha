import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/full_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/list_of_orders.dart';
import 'package:flutter/material.dart';

class SearchedOrderResutl extends StatelessWidget {
  const SearchedOrderResutl({
    super.key,
    required this.searchKey,
    required this.searchedList,
    required this.isSearchLoading,
    required this.backToMain,
    required this.bloc,
    this.enableAddress = true,
  });
  final String searchKey;
  final void Function() backToMain;
  final ManagementBloc bloc;
  final bool isSearchLoading;
  final bool enableAddress;
  final List<OrderModel> searchedList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "نتائج البحث الخاصة ب ",
              style: AppFontStyles.extraBoldNew30(context),
            ),
            Text(
              searchKey,
              style: AppFontStyles.extraBoldNew18(context),
            ),
            const Spacer(),
            TextButton(
                onPressed: backToMain,
                child: Text("العودة للرئيسية",
                    style: AppFontStyles.extraBoldNew20(context).copyWith(
                      color: AppColors.blue,
                    )))
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        isSearchLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : searchedList.isNotEmpty
                ? Expanded(
                    child: Scrollbar(
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(scrollbars: false),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CustomScrollView(
                            primary: true,
                            slivers: [
                              SliverToBoxAdapter(
                                child: FullTableHeader(
                                  enableAddress: enableAddress,
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 12,
                                ),
                              ),
                              ListOfOrder(
                                enableAddress: enableAddress,
                                bloc: bloc,
                                orderList: searchedList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        "لا يوجد اي تطابق مع كلمات البحث",
                        style: AppFontStyles.extraBoldNew38(context),
                      ),
                    ),
                  ),
      ],
    );
  }
}
