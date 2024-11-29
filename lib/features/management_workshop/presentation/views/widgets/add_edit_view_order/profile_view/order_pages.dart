import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/one_order_view_in_customer.dart';
import 'package:flutter/material.dart';

class OrdersPagesForCustomerView extends StatelessWidget {
  const OrdersPagesForCustomerView({
    super.key,
    required this.currPage,
    required this.model,
    required this.stepDown,
    required this.onChangeCurrPage,
    required this.editOrder,
  });

  final void Function(bool) onChangeCurrPage;
  final void Function(PillModel) stepDown;
  final int currPage;
  final CustomerModel model;
  final void Function(OrderModel) editOrder;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Row(
        children: [
          IconButton(
            onPressed: currPage > 0
                ? () {
                    onChangeCurrPage(false);
                  }
                : null,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 45,
              color: currPage > 0 ? null : AppColors.blackOpacity25,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ...List.generate(1, (index) {
            return Expanded(
              flex: 4,
              child: OneOrderInViewCustomerProfile(
                orderModel: model.orderModelList[currPage],
                stepDown: () {
                  stepDown(model.orderModelList[currPage].pillModel!);
                },
                editOrder: () {
                  editOrder(model.orderModelList[currPage]);
                },
              ),
            );
          }),
          const SizedBox(
            width: 12,
          ),
          IconButton(
            onPressed: currPage < model.orderModelList.length-1
                ? () {
                    onChangeCurrPage(true);
                  }
                : null,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 45,
              color: currPage < model.orderModelList.length - 1
                  ? AppColors.green
                  : AppColors.blackOpacity25,
            ),
          ),
        ],
      ),
    );
  }
}
