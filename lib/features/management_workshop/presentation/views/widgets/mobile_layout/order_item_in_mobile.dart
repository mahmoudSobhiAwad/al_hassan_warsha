import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OrderItemInMobile extends StatelessWidget {
  const OrderItemInMobile({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: switch (orderModel.orderStatus) {
            null => AppColors.blue,
            OrderStatus.neverDone => AppColors.red,
            OrderStatus.veryNear => AppColors.orange,
            OrderStatus.finished => AppColors.green,
          }),
          
      child: Column(
        children: [
          Text(
            orderModel.orderName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFontStyles.semiBold14(context)
                .copyWith(color: AppColors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Flexible(
            child: DetailsInOrderItemMobile(
                title: orderModel.customerModel?.customerName ?? "",
                iconData: Icons.person),
          ),
          Flexible(
            child: DetailsInOrderItemMobile(
                title: DateFormat('d MMMM y', 'ar')
                    .format(orderModel.recieveTime ?? DateTime.now()),
                iconData: Icons.calendar_month_rounded),
          ),
          Flexible(
            child: DetailsInOrderItemMobile(
              textStyle: AppFontStyles.extraBold14(context).copyWith(color: AppColors.white,letterSpacing: 3),
                title:
                    '${convertToArabicNumbers(orderModel.pillModel!.remian)}جنية',
                iconData: FontAwesomeIcons.sackDollar),
          ),
        ],
      ),
    );
  }
}

class DetailsInOrderItemMobile extends StatelessWidget {
  const DetailsInOrderItemMobile(
      {super.key, required this.title, required this.iconData,this.textStyle,this.color,this.width,this.maxLines});
  final String title;
  final TextStyle?textStyle;
  final IconData iconData;
  final Color?color;
  final double?width;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: null,
          icon: Icon(
            iconData,
            color: color??AppColors.white,
          ),
        ),
        SizedBox(
          width:width,
          child: Text(
            title,
            maxLines:maxLines?? 1,
            overflow: TextOverflow.ellipsis,
            style:
              textStyle??  AppFontStyles.semiBold14(context).copyWith(color: color??AppColors.white),
          ),
        ),
      ],
    );
  }
}
