import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bottom_actions_in_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/upper_action_view_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/get_contract/get_contract.dart';
import 'package:flutter/material.dart';

class ShowOneOrderBody extends StatelessWidget {
  const ShowOneOrderBody(
      {super.key,
      required this.orderModel,
      required this.navToEdit,
      required this.deleteOrder,
      required this.navToProfileView,
      required this.isLoading,
      required this.markAsDone});

  final OrderModel orderModel;
  final void Function(OrderModel orderModel) navToEdit;
  final void Function(String, List<MediaOrderModel>) deleteOrder;
  final void Function(String, bool) markAsDone;
  final void Function(String customerId) navToProfileView;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Scrollbar(
        radius: const Radius.circular(5),
        thickness: 15,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: CustomScrollView(
              primary: true,
              slivers: [
                SliverToBoxAdapter(
                  child: UpperButtonsInViewOrder(
                    navToEdit: () {
                      navToEdit(orderModel);
                    },
                    getPdfContract: () async {
                      await getPdfContract(orderModel);
                    },
                    onTapForCustomerProfileView: () {
                      navToProfileView(orderModel.customerId);
                    },
                  ),
                ),
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
                        style: AppFontStyles.extraBoldNew20(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RowOrderItems(
                          isReadOnly: true,
                          orderModel: orderModel,
                          colorOrderModel:
                              orderModel.colorModel ?? ColorOrderModel()),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomColumnWithTextInAddNewType(
                        text: "ملاحظات",
                        textLabel: "",
                        initalText: orderModel.notice,
                        enableBorder: true,
                        readOnly: true,
                        maxLine: 6,
                        onChanged: (value) {
                          orderModel.notice = value;
                        },
                        textStyle: AppFontStyles.extraBoldNew16(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "الوسائط",
                        style: AppFontStyles.extraBoldNew16(context),
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
                        isReadOnly: true,
                        list: orderModel.extraOrdersList,
                        removeItem: (index) {},
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
                    enableController: true,
                    pillModel: orderModel.pillModel!,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                    child: BottomActionOrderInViewOrder(
                        orderModel: orderModel,
                        markAsDone: markAsDone,
                        deleteOrder: deleteOrder,
                        isLoading: isLoading))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
