import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/list_order_financial.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';

class SearchedListInFinancial extends StatelessWidget {
  const SearchedListInFinancial({
    super.key,
    required this.searchKeyWord,
    required this.controlSearchState,
    required this.searchedList,
    required this.scrollController,
    required this.downStep,
    this.isTabletLayOut=false,
  });

  final String searchKeyWord;
  final void Function() controlSearchState;
  final List<OrderModel> searchedList;
  final ScrollController scrollController;
  final bool isTabletLayOut;
  final void Function(
      {required String addedAmount,
      required String pillId,
      required String totalPayedAmount}) downStep;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "عرض الفواتير الخاصة ب",
                style: AppFontStyles.bold18(context),
              ),
              Text(
                searchKeyWord,
                style: AppFontStyles.bold18(context),
              ),
              const Spacer(),
              TextButton(
                onPressed: controlSearchState,
                child: Text(
                  "العودة للرئيسية ",
                  style: AppFontStyles.bold18(context)
                      .copyWith(color: AppColors.blue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          searchedList.isNotEmpty
              ? ListOfOrdersInFinancial(
                isTabletLayOut:isTabletLayOut ,
                  controller: scrollController,
                  orderList: searchedList,
                  downStep: downStep)
              : Center(
                  child: Text(
                    "لا يوجد اي فواتير مستحقة ",
                    style: AppFontStyles.extraBoldNew24(context),
                  ),
                ),
        ],
      ),
    );
  }
}
