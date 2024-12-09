import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/first_page_in_order_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/second_page_in_order_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/third_page_in_order_mobile.dart';
import 'package:flutter/material.dart';

class AddOrderViewMobile extends StatelessWidget {
  const AddOrderViewMobile({super.key, required this.bloc, this.customerModel});
  final ManagementBloc bloc;
  final CustomerModel? customerModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "اضافة طلب جديد",
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: PageView(
            controller: bloc.pageControllerInMobileOrder,
            physics:const NeverScrollableScrollPhysics(),
            children: [
              FirstPageInAddOrderInMobileLayout(
                isReadOnly: false,
                orderModel: bloc.orderModel,
                formKey: bloc.fromKey,
                colorModel: bloc.colorModel,
                customerModel: bloc.customerModel,
                pillModel: bloc.pillModel,
                onChangeNotice: (notice) {
                  bloc.orderModel.notice = notice;
                },
                onChangeColorValue: (colorHex) {
                  bloc.add(ChangeColorOfOrderEvent(colorValue: colorHex));
                },
                onChangeDate: (date) {
                  bloc.add(ChangeDateOfOrderEvent(dateTime: date));
                },
                allKitchenTypes: bloc.allKitchenTypes,
                onChangeKitchenType: (type) {
                  bloc.add(ChangeKitchenTypeEvent(kitchenType: type));
                },
              ),
              SecondPageInOrderMobile(
                list: bloc.extraOrdersList,
                mediaOrderList: bloc.mediaOrderList,
                addMedia: (list) {
                  bloc.add(AddMediaInAddOrder(list: list));
                },
                addMoreExtras: () {
                  bloc.add(AddExtraInOrder());
                },
                addMoreMedia: (items) {
                  bloc.add(AddMediaInAddOrder(list: items));
                },
                removeItemFromExtras: (index) {
                  bloc.add(RemoveExtraItem(index: index));
                },
                removeMedia: (index) {
                  bloc.add(RemoveMediItemEvent(index: index));
                },
              ),
              ThirdPageInOrderMobile(
                pillModel: bloc.pillModel,
                onTapToChangeRemain: () {
                  bloc.add(ChangeRemainInAddOrderEvent());
                },
                enableController: false,
                changeStepsCounter: (status) {
                  bloc.add(ChangeCounterOfStepsInPillEvent(increase: status));
                },
                onChangePayment: (payment) {
                  bloc.add(ChangeOptionPaymentEvent(paymentWay: payment));
                },
                formKey: bloc.fromKey,
                addOrder: () {
                  bloc.add(AddNewOrderEvent(customerModel: customerModel));
                },
                isLoading: bloc.isLoadingActionsOrder,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: bloc.currPageMobile == 0
                    ? null
                    : () {
                        bloc.add(ChangeCurrPageInMobile(isForward: false));
                      },
                child: Text(
                  "العودة",
                  style: AppFontStyles.extraBold14(context).copyWith(
                      color: bloc.currPageMobile != 0
                          ? AppColors.blueGray
                          : AppColors.lightGray1),
                )),
            TextButton(
                onPressed: bloc.currPageMobile == 2
                    ? null
                    : () {
                        bloc.add(ChangeCurrPageInMobile(isForward: true));
                      },
                child: Text(
                  "الخطوة القادمة",
                  style: AppFontStyles.extraBold14(context).copyWith(
                      color: bloc.currPageMobile != 2
                          ? AppColors.blue
                          : AppColors.lightGray1),
                )),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
