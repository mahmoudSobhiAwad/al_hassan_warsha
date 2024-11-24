import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';

class ShowOneOrderBody extends StatelessWidget {
  const ShowOneOrderBody(
      {super.key,
      required this.orderModel,
      required this.navToEdit,
      required this.deleteOrder,
      required this.markAsDone});

  final OrderModel orderModel;
  final void Function(OrderModel orderModel) navToEdit;
  final void Function(String, List<MediaOrderModel>) deleteOrder;
  final void Function(String, bool) markAsDone;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: CustomScrollView(
        slivers: [
          UpperButtonsInViewOrder(navToEdit: navToEdit, orderModel: orderModel),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomerInfoInOrder(
              isReadOnly: true,
              model: orderModel.customerModel!,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تفاصيل الطلب",
                  style: AppFontStyles.extraBold24(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                RowOrderItems(
                    orderModel: orderModel,
                    colorOrderModel: orderModel.colorModel!),
                const SizedBox(
                  height: 10,
                ),
                CustomColumnWithTextInAddNewType(
                  text: "ملاحظات",
                  textLabel: "",
                  controller:
                      TextEditingController(text: orderModel.notice ?? ""),
                  enableBorder: true,
                  readOnly: true,
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
                orderModel.mediaOrderList.isNotEmpty
                    ? MediaListExist(
                        enableClear: false,
                        pickedList: orderModel.getPickedMedia(),
                      )
                    : const EmptyUploadMedia(),
                const SizedBox(
                  height: 16,
                ),
                AddsForOrder(
                  list: orderModel.extraOrdersList,
                ),
              ],
            ),
          )),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: BillDetails(
              pillModel: orderModel.pillModel!,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: orderModel.orderStatus != OrderStatus.finished
                ? DialogAddNewTypeActionButton(
                    text_1: " تسليم الطلب",
                    onPressed_1: () {
                      markAsDone(orderModel.orderId, true);
                    },
                    text_2: "حذف الطلب",
                    onPressed_2: () {
                      deleteOrder(
                          orderModel.orderId, orderModel.mediaOrderList);
                    },
                  )
                : Center(
                  child: CustomPushContainerButton(
                      onTap: () {
                        markAsDone(orderModel.orderId, false);
                      },
                      color: AppColors.red,
                      borderRadius: 14,
                      iconBehind: Icons.restart_alt_rounded,
                      pushButtomText: " تمييز كغير مسلم",
                    ),
                ),
          )
        ],
      ),
    ));
  }
}

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
          const CustomPushContainerButton(
            borderRadius: 12,
            pushButtomText: " استخراج نسخة عقد",
            iconBehind: Icons.file_present_sharp,
            color: AppColors.blueGray,
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ],
      ),
    );
  }
}