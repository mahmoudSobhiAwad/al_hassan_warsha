import 'dart:async';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/empyt_upload_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/list_of_exist_media.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_more_extra.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/bill_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/row_order_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrderView extends StatelessWidget {
  const EditOrderView(
      {super.key, required this.bloc, required this.orderModel});
  final ManagementBloc bloc;
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: bloc,
        builder: (context, state) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                  child: Scaffold(
                backgroundColor: AppColors.white,
                body: Column(
                  children: [
                    AppBarWithLinking(items: [
                      "تعديل طلب ",
                      orderModel.orderName,
                    ]),
                    Expanded(
                        child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: CustomerInfoInOrder(
                              model: orderModel.customerModel!),
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
                                  allKitchenTypes: bloc.allKitchenTypes,
                                  changeColorValue: (value) {
                                    bloc.add(ChangeColorOfOrderEvent(
                                        colorValue: value, isEdit: true));
                                  },
                                  changeDate: (time) {
                                    bloc.add(ChangeDateOfOrderEvent(
                                        dateTime: time, isEdit: true));
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
                                controller: TextEditingController(
                                    text: orderModel.notice ?? ""),
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
                              orderModel.mediaOrderList.isNotEmpty
                                  ? MediaListExist(
                                      addMore: (media) {
                                        bloc.add(AddMediaInAddOrder(
                                            list: media, isEdit: true));
                                      },
                                      removeIndex: (index) {
                                        bloc.add(RemoveMediItemEvent(
                                            index: index, isEdit: true));
                                      },
                                      enableClear: true,
                                      pickedList: orderModel.getPickedMedia(),
                                    )
                                  : EmptyUploadMedia(
                                      addMedia: (media) {
                                        bloc.add(AddMediaInAddOrder(
                                            list: media, isEdit: true));
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
                                  bloc.add(RemoveExtraItem(
                                      index: index, isEdit: true));
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
                                  bloc.add(ChangeRemainInAddOrderEvent(
                                      isEdit: true));
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
                                  pushButtomText: "تعديل",
                                  onTap: () {
                                    bloc.add(EditOrderEvent());
                                  },
                                  iconBehind: Icons.edit,
                                  iconSize: 30,
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
                    )),
                  ],
                ),
              )));
        },
        listener: (context, state) {
          if (state is FailureEditOrderModelState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColors.red);
          } else if (state is SuccessEditOrderModelState) {
            showCustomSnackBar(context, "تم التعديل بنجاح ");
            Timer(const Duration(milliseconds: 1500), () {
              Navigator.pop(context);
            });
          }
        });
  }
}
