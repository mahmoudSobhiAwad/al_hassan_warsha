import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_phone.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/home_address.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/one_order_item_customer_profile.dart';
import 'package:flutter/material.dart';

class MobileTabletProfileView extends StatelessWidget {
  const MobileTabletProfileView({
    super.key,
    required this.customerModel,
    required this.stepDown,
    required this.addNewOrder,
    required this.navigteToEdit,
    this.textStyle,
    this.edgeInsets,
  });
  final CustomerModel customerModel;
  final void Function(PillModel) stepDown;
  final void Function() addNewOrder;
  final void Function(OrderModel) navigteToEdit;
  final TextStyle? textStyle;
  final EdgeInsets? edgeInsets;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "ملف شخصي",
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            Navigator.pop(context);
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5),
            child: CustomPushContainerButton(
              enableIcon: false,
              pushButtomText: "اضافة طلب جديد",
              pushButtomTextFontSize: textStyle?.fontSize ?? 16,
              onTap: addNewOrder,
              borderRadius: 8,
              padding: edgeInsets ??
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "بيانات العميل",
                        style: textStyle ?? AppFontStyles.bold18(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: CustomerNameInOrder(
                                  model: customerModel,
                                  isReadOnly: true,
                                  textStyle: textStyle ??
                                      AppFontStyles.bold16(context),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: NumberPhoneInOrder(
                                  model: customerModel,
                                  isReadOnly: true,
                                  textStyle: textStyle ??
                                      AppFontStyles.bold16(context),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: HomeAddressInOrder(
                                  model: customerModel,
                                  isReadOnly: true,
                                  textStyle: textStyle ??
                                      AppFontStyles.bold16(context),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 3,
                                child: SecondPhoneInOrder(
                                  model: customerModel,
                                  isReadOnly: true,
                                  textStyle: textStyle ??
                                      AppFontStyles.bold16(context),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Text(
                    "كل الطلبات (${customerModel.orderModelList.length})",
                    style: AppFontStyles.extraBoldNew21(context),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return OneOrderItemInCustomerProfile(
                      edgeInsets: edgeInsets,
                      textStyle: textStyle,
                      navigteToEdit: () {
                        navigteToEdit(customerModel.orderModelList[index]);
                      },
                      orderName: customerModel.orderModelList[index].orderName,
                      pillModel: customerModel.orderModelList[index].pillModel!,
                      stepDown: () {
                        stepDown(
                            customerModel.orderModelList[index].pillModel!);
                      },
                    );
                  },
                  childCount: customerModel.orderModelList.length,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
