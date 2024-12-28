import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/customer_bill_item.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderListInCustomerBillMobileLayOut extends StatelessWidget {
  const OrderListInCustomerBillMobileLayOut({
    super.key,
    required this.orderList,
    required this.stepDown,
  });

  final List<OrderModel> orderList;
  final void Function(
      {required String addedAmount,
      required String pillId,
      required String totalPayedAmount}) stepDown;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: orderList.isNotEmpty
            ? ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(scrollbars: false),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CustomerBillItem(
                          orderModel: orderList[index], stepDown: stepDown);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: orderList.length),
              )
            : Center(
                child: Text(
                  "لا يوجد اي فواتير مستحقة ",
                  style: AppFontStyles.extraBoldNew24(context),
                ),
              ));
  }
}
