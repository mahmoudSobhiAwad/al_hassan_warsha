import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/step_down_in_each_order.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/stepper_amount_in_each_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/order_item_in_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerBillItem extends StatelessWidget {
  const CustomerBillItem(
      {super.key, required this.orderModel, required this.stepDown});
  final OrderModel orderModel;
  final void Function(
      {required String addedAmount,
      required String pillId,
      required String totalPayedAmount}) stepDown;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGray1, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    color: AppColors.veryLightGray2,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: DetailsInOrderItemMobile(
                  width: context.screenWidth * 0.2,
                  maxLines: 2,
                  title: orderModel.pillModel?.customerName ?? "",
                  iconData: Icons.person,
                  color: AppColors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    color: AppColors.veryLightGray2,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: DetailsInOrderItemMobile(
                  maxLines: 2,
                  width: context.screenWidth * 0.2,
                  title: orderModel.orderName,
                  iconData: Icons.shopping_cart_rounded,
                  color: AppColors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    color: AppColors.veryLightGray2,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: DetailsInOrderItemMobile(
                  width: context.screenWidth * 0.15,
                  title: orderModel.pillModel?.remian ?? "",
                  iconData: FontAwesomeIcons.database,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                  flex: 6,
                  child: AmountToDowStepInCustomerBill(
                      pillModel: orderModel.pillModel)),
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 4,
                child: StepDownInBillCustomerItem(
                    pillModel: orderModel.pillModel,
                    textStyle: AppFontStyles.bold16(context)
                        .copyWith(color: AppColors.white),
                    downStep: stepDown),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
