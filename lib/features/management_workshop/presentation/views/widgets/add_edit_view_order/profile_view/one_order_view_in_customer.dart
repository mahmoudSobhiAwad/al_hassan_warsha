import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/pay_pill_in_customer_profile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';

class OneOrderInViewCustomerProfile extends StatelessWidget {
  const OneOrderInViewCustomerProfile(
      {super.key,
      required this.orderModel,
      required this.stepDown,
      required this.editOrder});
  final OrderModel orderModel;
  final void Function() stepDown;
  final void Function() editOrder;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Text(
                  orderModel.orderName,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyles.extraBoldNew28(context),
                )),
            CustomPushContainerButton(
              borderRadius: 14,
              iconBehind: Icons.edit,
              iconSize: 25,
              onTap: editOrder,
              pushButtomText: 'تعديل الطلب',
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        RowOrderItems(
          isReadOnly: true,
            showKitchenName: false,
            orderModel: orderModel,
            colorOrderModel: orderModel.colorModel!),
        const SizedBox(
          height: 12,
        ),
        const SizedBox(
          height: 12,
        ),
        AddsForOrder(
          isReadOnly: true,
          removeItem: (index) {},
          list: orderModel.extraOrdersList,
        ),
        const SizedBox(
          height: 12,
        ),
        BillDetails(pillModel: orderModel.pillModel!, enableController: true),
        const SizedBox(
          height: 12,
        ),
        PayPillInCustomerProfile(orderModel: orderModel, stepDown: stepDown),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
