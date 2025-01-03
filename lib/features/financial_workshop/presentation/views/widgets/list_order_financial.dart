import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/one_table_content.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';

class ListOfOrdersInFinancial extends StatelessWidget {
  const ListOfOrdersInFinancial({
    super.key,
    required this.controller,
    required this.orderList,
    required this.downStep,
    this.isTabletLayOut=false,
  });

  final ScrollController controller;
  final bool isTabletLayOut;
  final List<OrderModel> orderList;
  final void Function({
    required String pillId,
    required String addedAmount,
    required String totalPayedAmount,
  }) downStep;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.6,
        child: Scrollbar(
          controller: controller,
          thickness: 12,
          scrollbarOrientation: ScrollbarOrientation.right,
          thumbVisibility: true,
          radius: const Radius.circular(10),
          child: Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: ListView.separated(
                controller: controller,
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return ContentOfFinancialTable(
                    isTabletLayOut: isTabletLayOut,
                    downStep: (
                        {required String addedAmount,
                        required String pillId,
                        required String totalPayedAmount}) {
                      downStep(
                          totalPayedAmount: totalPayedAmount,
                          pillId: pillId,
                          addedAmount: addedAmount);
                    },
                    orderName: orderList[index].orderName,
                    pillModel: orderList[index].pillModel!,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.only(bottom: 16));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
