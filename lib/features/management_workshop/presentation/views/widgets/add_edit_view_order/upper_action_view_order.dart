import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/get_contract.dart';
import 'package:flutter/material.dart';

class UpperButtonsInViewOrder extends StatelessWidget {
  const UpperButtonsInViewOrder({
    super.key,
    required this.navToEdit,
    required this.orderModel,
  });

  final void Function(OrderModel orderModel) navToEdit;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomPushContainerButton(
            borderRadius: 12,
            onTap: () {
              navToEdit(orderModel);
            },
            pushButtomText: "تعديل الطلب",
            iconBehind: Icons.edit,
            iconSize: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          const SizedBox(
            width: 12,
          ),
          const CustomPushContainerButton(
            borderRadius: 12,
            pushButtomText: "عرض الملف الشخصي ",
            iconBehind: Icons.person,
            color: AppColors.orange,
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          const SizedBox(
            width: 12,
          ),
          CustomPushContainerButton(
            borderRadius: 12,
            onTap: () async {
              await getPdfContract(orderModel);
            },
            pushButtomText: " استخراج نسخة عقد",
            iconBehind: Icons.file_present_sharp,
            color: AppColors.blueGray,
            iconSize: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ],
      ),
    );
  }
}
