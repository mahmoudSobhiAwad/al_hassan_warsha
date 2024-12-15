import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {super.key,
      required this.orderModel,
      required this.colorOrderModel,
      required this.changeColorValue,
      required this.changeDate,
      required this.changekitchenTypeValue,
      required this.addMore,
      required this.extraList,
      this.formKey,
      required this.delteItem,
      required this.pickedMeidaList,
      required this.addMoreMedia,
      this.kitchenTypesList = const [],
      required this.isReadOnly,
      required this.delteMedia});
  final OrderModel orderModel;
  final ColorOrderModel colorOrderModel;
  final void Function(int) changeColorValue;
  final void Function(String) changekitchenTypeValue;
  final void Function(DateTime) changeDate;
  final List<ExtraInOrderModel> extraList;
  final void Function() addMore;
  final void Function(int index) delteItem;
  final void Function(List<String>) addMoreMedia;
  final void Function(int index) delteMedia;
  final List<PickedMedia> pickedMeidaList;
  final GlobalKey<FormState>? formKey;
  final List<String> kitchenTypesList;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تفاصيل الطلب",
          style: AppFontStyles.extraBoldNew20(context),
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
                isReadOnly: isReadOnly,
                  allKitchenTypes: kitchenTypesList,
                  formKey: formKey,
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
                maxLine: 7,
                controller: TextEditingController(text: orderModel.notice),
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
              pickedMeidaList.isNotEmpty
                  ? MediaListExist(
                      addMore: (media) {
                        addMoreMedia(media);
                      },
                      enableClear: true,
                      pickedList: pickedMeidaList,
                      removeIndex: (index) {
                        delteMedia(index);
                      },
                    )
                  : EmptyUploadMedia(
                      addMedia: (media) {
                        addMoreMedia(media);
                      },
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
