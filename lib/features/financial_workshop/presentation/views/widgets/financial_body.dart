import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/one_table_content.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/table_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class FinancialBody extends StatelessWidget {
  const FinancialBody({
    super.key,
    required this.orderList,
    required this.downStep,
    required this.onChangeIndex,
    required this.totalLength,
    required this.currentPage,
  });
  final List<OrderModel> orderList;
  final void Function({required String pillId, required String amount})
      downStep;
  final int totalLength;
  final void Function(int) onChangeIndex;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          SearchBarInManagment(
            changeSearchType: (mode) {},
            searchFunc: () {},
            changeSearchText: (vla) {},
            searchKey: SearchModel(valueArSearh: " ", valueEnSearh: ""),
          ),
          const SizedBox(
            height: 24,
          ),
          const TableHeaderInFinancial(),
          const SizedBox(
            height: 10,
          ),
          orderList.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      "لا يوجد اي فواتير مستحقة ",
                      style: AppFontStyles.extraBold30(context),
                    ),
                  ),
                )
              : Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: ListView.separated(
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        return ContentOfFinancialTable(
                          downStep: (
                              {required String amount,
                              required String pillId}) {
                            downStep(amount: amount, pillId: pillId);
                          },
                          orderName: orderList[index].orderName,
                          pillModel: orderList[index].pillModel!,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                            padding: EdgeInsets.only(bottom: 16));
                      },
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          totalLength > 10
              ? CustomPaginationWidget(
                  length: totalLength,
                  currentPage: currentPage,
                  onPageChanged: onChangeIndex)
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
