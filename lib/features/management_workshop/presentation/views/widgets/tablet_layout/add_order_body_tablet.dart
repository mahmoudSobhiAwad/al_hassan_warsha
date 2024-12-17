import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/customer_info_tablet.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/order_details_tablet.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/pill_details_tablet.dart';
import 'package:flutter/material.dart';

class CustomOrderBodyTablet extends StatelessWidget {
  const CustomOrderBodyTablet(
      {super.key,
      required this.bloc,
      this.model,
      this.orderModel,
      this.isEdit = false,
      required this.bottomActionWidget,
      this.isReadOnly = false});
  final ManagementBloc bloc;
  final CustomerModel? model;
  final OrderModel? orderModel;
  final bool isReadOnly;
  final bool isEdit;
  final Widget bottomActionWidget;
  @override
  Widget build(BuildContext context) {
    return Form(
      key:isEdit?bloc.fromKeyEdit: bloc.fromKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CustomScrollView(
                scrollBehavior:
                    const ScrollBehavior().copyWith(scrollbars: false),
                primary: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomerInfoInOrderInTablet(
                      formKey: isEdit ? bloc.fromKeyEdit : bloc.fromKey,
                      isReadOnly: isReadOnly,
                      model: orderModel?.customerModel ??
                          model ??
                          bloc.customerModel,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: OrderDetailsInTablet(
                      aboveTextStyle: AppFontStyles.extraBoldNew16(context),
                      isReadOnly: isReadOnly,
                      allKitchenTypes: bloc.allKitchenTypes,
                      formKey: isEdit ? bloc.fromKeyEdit : bloc.fromKey,
                      colorOrderModel:
                          orderModel?.colorModel ?? bloc.colorModel,
                      orderModel: orderModel ?? bloc.orderModel,
                      changeColorValue: (value) {
                        bloc.add(ChangeColorOfOrderEvent(
                            colorValue: value, isEdit: isEdit));
                      },
                      changeDate: (time) {
                        bloc.add(ChangeDateOfOrderEvent(
                            dateTime: time, isEdit: isEdit));
                      },
                      changekitchenTypeValue: (type) {
                        bloc.add(ChangeKitchenTypeEvent(
                            kitchenType: type, isEdit: isEdit));
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomColumnWithTextInAddNewType(
                      text: "ملاحظات",
                      readOnly: isReadOnly,
                      textLabel: "",
                      enableBorder: true,
                      maxLine: 5,
                      controller: TextEditingController(
                          text: orderModel?.notice ?? bloc.orderModel.notice),
                      onChanged: (value) {
                        orderModel != null
                            ? orderModel?.notice = value
                            : bloc.orderModel.notice = value;
                      },
                      textStyle: AppFontStyles.extraBoldNew16(context),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: orderModel?.mediaOrderList.isNotEmpty ??
                            bloc.mediaOrderList.isNotEmpty
                        ? MediaListExist(
                            addMore: (media) {
                              isReadOnly
                                  ? null
                                  : bloc.add(AddMediaInAddOrder(list: media,isEdit: isEdit));
                            },
                            enableClear: !isReadOnly,
                            pickedList: orderModel?.getPickedMedia() ??
                                bloc.mediaOrderList,
                            removeIndex: (index) {
                              isReadOnly
                                  ? null
                                  : bloc.add(RemoveMediItemEvent(index: index,isEdit: isEdit));
                            },
                          )
                        : EmptyUploadMedia(
                            isReadOnly: isReadOnly,
                            fontSize: 20,
                            addMedia: (media) {
                              bloc.add(AddMediaInAddOrder(list: media,isEdit: isEdit));
                            },
                          ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AddsForOrder(
                      
                      isReadOnly: isReadOnly,
                      list: orderModel?.extraOrdersList ?? bloc.extraOrdersList,
                      addMore: () {
                        isReadOnly ? null : bloc.add(AddExtraInOrder(isEdit: isEdit));
                      },
                      removeItem: (index) {
                        isReadOnly
                            ? null
                            : bloc.add(RemoveExtraItem(index: index,isEdit: isEdit));
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BillDetailsInTablet(
                      enableController: isReadOnly,
                      onTapToChangeRemain: () {
                        isReadOnly
                            ? null
                            : bloc.add(ChangeRemainInAddOrderEvent(isEdit: isEdit));
                      },
                      changeStepsCounter: (increase) {
                        isReadOnly
                            ? null
                            : bloc.add(ChangeCounterOfStepsInPillEvent(
                                increase: increase,isEdit: isEdit));
                      },
                      pillModel: orderModel?.pillModel ?? bloc.pillModel,
                      onChangePayment: (paymentWay) {
                        bloc.add(
                            ChangeOptionPaymentEvent(paymentWay: paymentWay,isEdit: isEdit));
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 12,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: bottomActionWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
