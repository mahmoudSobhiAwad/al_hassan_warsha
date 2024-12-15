import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_new_order_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/customer_info_tablet.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/order_details_tablet.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/pill_details_tablet.dart';
import 'package:flutter/material.dart';

class AddOrderBodyTabletLayOut extends StatelessWidget {
  const AddOrderBodyTabletLayOut({super.key, required this.bloc, this.model});
  final ManagementBloc bloc;
  final CustomerModel? model;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.fromKey,
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
                      formKey: bloc.fromKey,
                      isReadOnly: model != null,
                      model: model ?? bloc.customerModel,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: OrderDetailsInTablet(
                      isReadOnly: false,
                      allKitchenTypes: bloc.allKitchenTypes,
                      formKey: bloc.fromKey,
                      colorOrderModel: bloc.colorModel,
                      orderModel: bloc.orderModel,
                      changeColorValue: (value) {
                        bloc.add(ChangeColorOfOrderEvent(colorValue: value));
                      },
                      changeDate: (time) {
                        bloc.add(ChangeDateOfOrderEvent(dateTime: time));
                      },
                      changekitchenTypeValue: (type) {
                        bloc.add(ChangeKitchenTypeEvent(kitchenType: type));
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
                      textLabel: "",
                      enableBorder: true,
                      maxLine: 5,
                      controller:
                          TextEditingController(text: bloc.orderModel.notice),
                      onChanged: (value) {
                        bloc.orderModel.notice = value;
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
                    child: bloc.mediaOrderList.isNotEmpty
                        ? MediaListExist(
                            addMore: (media) {
                              bloc.add(AddMediaInAddOrder(list: media));
                            },
                            enableClear: true,
                            pickedList: bloc.mediaOrderList,
                            removeIndex: (index) {
                              bloc.add(RemoveMediItemEvent(index: index));
                            },
                          )
                        : EmptyUploadMedia(
                            fontSize: 20,
                            addMedia: (media) {
                              bloc.add(AddMediaInAddOrder(list: media));
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
                      list: bloc.extraOrdersList,
                      addMore: () {
                        bloc.add(AddExtraInOrder());
                      },
                      removeItem: (index) {
                        bloc.add(RemoveExtraItem(index: index));
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
                      enableController: false,
                      onTapToChangeRemain: () {
                        bloc.add(ChangeRemainInAddOrderEvent());
                      },
                      changeStepsCounter: (increase) {
                        bloc.add(ChangeCounterOfStepsInPillEvent(
                            increase: increase));
                      },
                      pillModel: bloc.pillModel,
                      onChangePayment: (paymentWay) {
                        bloc.add(
                            ChangeOptionPaymentEvent(paymentWay: paymentWay));
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 12,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AddNewOrderButton(
                      formKey: bloc.fromKey,
                      addOrder: () {
                        bloc.add(AddNewOrderEvent(customerModel: model));
                      },
                      isLoading: bloc.isLoadingActionsOrder,
                    ),
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
