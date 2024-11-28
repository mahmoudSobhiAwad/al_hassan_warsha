import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OneOrderItem extends StatelessWidget {
  const OneOrderItem({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.lightGray2)),
      child: Row(
        children: [
          Expanded(
              child: CustomTextWithTheSameStyle(
            text: orderModel.orderName,
          )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: DateFormat('d MMMM y', 'ar')
                    .format(orderModel.recieveTime ?? DateTime.now()),
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: orderModel.customerModel?.customerName ?? "",
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: orderModel.customerModel?.phone ?? "غير محدد",
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: orderModel.customerModel?.homeAddress ?? "غير محدد",
              )),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                  text: switch (orderModel.orderStatus) {
                null => "",
                OrderStatus.neverDone => "لم يتم التسليم",
                OrderStatus.veryNear => "اقترب التسليم",
                OrderStatus.finished => "تم التسليم"
              })),
          const Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                
                textStyle: AppFontStyles.bold24(context).copyWith(letterSpacing: 3),
                text:convertToArabicNumbers(orderModel.pillModel!.remian),
              )),
        ],
      ),
    );
  }
}
