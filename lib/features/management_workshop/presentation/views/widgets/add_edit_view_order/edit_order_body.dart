import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';

class EditOrderBody extends StatelessWidget {
  const EditOrderBody({
    super.key,
    required this.orderModel,
    required this.bloc,
  });

  final OrderModel orderModel;
  final ManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Scrollbar(
        radius:const Radius.circular(5),
        thickness: 12,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: CustomScrollView(
            primary: true,
            slivers: [
              SliverToBoxAdapter(
                child: CustomerInfoInOrder(model: orderModel.customerModel!),
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
                        allKitchenTypes: bloc.allKitchenTypes,
                        changeColorValue: (value) {
                          bloc.add(ChangeColorOfOrderEvent(
                              colorValue: value, isEdit: true));
                        },
                        changeDate: (time) {
                          bloc.add(
                              ChangeDateOfOrderEvent(dateTime: time, isEdit: true));
                        },
                        changekitchenTypeValue: (type) {
                          bloc.add(ChangeKitchenTypeEvent(
                              kitchenType: type, isEdit: true));
                        },
                        formKey: bloc.fromKey,
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
                      maxLine: 4,
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
                            addMore: (media) {
                              bloc.add(
                                  AddMediaInAddOrder(list: media, isEdit: true));
                            },
                            removeIndex: (index) {
                              bloc.add(
                                  RemoveMediItemEvent(index: index, isEdit: true));
                            },
                            enableClear: true,
                            pickedList: orderModel.getPickedMedia(),
                          )
                        : EmptyUploadMedia(
                            addMedia: (media) {
                              bloc.add(
                                  AddMediaInAddOrder(list: media, isEdit: true));
                            },
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    AddsForOrder(
                      addMore: () {
                        bloc.add(AddExtraInOrder(isEdit: true));
                      },
                      removeItem: (index) {
                        bloc.add(RemoveExtraItem(index: index, isEdit: true));
                      },
                      list: orderModel.extraOrdersList,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BillDetails(
                      enableController: false,
                      pillModel: orderModel.pillModel!,
                      onTapToChangeRemain: () {
                        bloc.add(ChangeRemainInAddOrderEvent(isEdit: true));
                      },
                      onChangePayment: (paymentWay) {
                        bloc.add(ChangeOptionPaymentEvent(
                            paymentWay: paymentWay, isEdit: true));
                      },
                      formKey: bloc.fromKey,
                      changeStepsCounter: (status) {
                        bloc.add(ChangeCounterOfStepsInPillEvent(
                            increase: status, isEdit: true));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: CustomPushContainerButton(
                        childInstead: bloc.isLoadingActionsOrder
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "تعديل ",
                                    style: AppFontStyles.extraBoldNew24(context)
                                        .copyWith(color: AppColors.white),
                                  ),
                                  const IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.edit,
                                        color: AppColors.white,
                                        size: 30,
                                      ))
                                ],
                              ),
                        onTap: () {
                          bloc.add(EditOrderEvent());
                        },
                        borderRadius: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    ));
  }
}
