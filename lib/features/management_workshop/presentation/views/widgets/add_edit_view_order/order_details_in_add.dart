import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.orderModel,
    required this.colorOrderModel,
    required this.changeColorValue,
    required this.changeDate,
    required this.changekitchenTypeValue,
    required this.addMore,
    required this.extraList,
    required this.delteItem,
  });
  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int) changeColorValue;
  final void Function(String) changekitchenTypeValue;
  final void Function(DateTime) changeDate;
  final List<ExtraInOrderModel> extraList;
  final void Function() addMore;
  final void Function(int index) delteItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تفاصيل الطلب",
          style: AppFontStyles.extraBold24(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowOrderItems(
                  orderModel: orderModel,
                  colorOrderModel: colorOrderModel,
                  changeColorValue: changeColorValue,
                  changekitchenTypeValue: changekitchenTypeValue,
                  changeDate: changeDate),
              const SizedBox(
                height: 10,
              ),
              CustomColumnWithTextInAddNewType(
                text: "ملاحظات",
                textLabel: "",
                enableBorder: true,
                maxLine: 4,
                onChanged: (value) {
                  orderModel.notice = value;
                },
                textStyle: AppFontStyles.extraBold18(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "الوسائط",
                style: AppFontStyles.extraBold18(context),
              ),
              const SizedBox(
                height: 10,
              ),

              /// incase of there are media
              // SizedBox(
              //   height: MediaQuery.sizeOf(context).height*0.2,
              //   child: const ListOfOneKitchenType(enableInner:false,enableClose: true,)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: AppColors.veryLightGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "ارفع بعض الصور ومقاطع الفيديو الخاصة بالمنتج ",
                        style: AppFontStyles.extraBold28(context),
                      ),
                      const Icon(
                        Icons.cloud_upload,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              AddsForOrder(
                list: extraList,
                addMore: addMore,
                removeItem: (index) {
                  delteItem(index);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
