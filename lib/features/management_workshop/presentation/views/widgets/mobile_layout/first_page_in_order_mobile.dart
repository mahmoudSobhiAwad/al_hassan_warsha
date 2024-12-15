import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_name.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_phone.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/get_color_for_order.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/home_address.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/ktichen_type_in_order_details.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/order_name_in_details.dart';
import 'package:flutter/material.dart';

class FirstPageInAddOrderInMobileLayout extends StatelessWidget {
  const FirstPageInAddOrderInMobileLayout(
      {super.key,
      required this.isReadOnly,
      required this.orderModel,
      required this.colorModel,
      required this.customerModel,
      required this.onChangeNotice,
      required this.onChangeColorValue,
      required this.onChangeDate,
      required this.allKitchenTypes,
      required this.onChangeKitchenType,
      required this.formKey});
  final bool isReadOnly;
  final OrderModel orderModel;
  final CustomerModel customerModel;
  final ColorOrderModel colorModel;
  final GlobalKey<FormState> formKey;
  final void Function(int) onChangeColorValue;
  final void Function(String) onChangeKitchenType;
  final void Function(String?) onChangeNotice;
  final void Function(DateTime) onChangeDate;
  final List<String> allKitchenTypes;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        primary: true,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "بيانات العميل",
                    style: AppFontStyles.bold18(context),
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
                              formKey: formKey,
                              model: customerModel,
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: NumberPhoneInOrder(
                              model: customerModel,
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
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
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: SecondPhoneInOrder(
                              model: customerModel,
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "تفاصيل الطلب",
                    style: AppFontStyles.bold18(context),
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
                            child: OrderNameInOrderDetails(
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
                              formKey: formKey,
                              orderModel: orderModel,
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: KitchenTypeInOrderDetails(
                              isReadOnly: isReadOnly,
                              textStyle: AppFontStyles.bold16(context),
                              orderModel: orderModel,
                              formKey: formKey,
                              changekitchenTypeValue: (String type) {
                                onChangeKitchenType(type);
                              },
                              allKitchenTypes: allKitchenTypes,
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
                            child: GetColorForOrder(
                              textStyle: AppFontStyles.bold16(context),
                              colorOrderModel: colorModel,
                              changeColorValue: isReadOnly
                                  ? null
                                  : (colorHex) {
                                      onChangeColorValue(colorHex);
                                    },
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: CustomDatePicker(
                                aboveTextStyle: AppFontStyles.bold16(context),
                                textInnerStyle: AppFontStyles.bold12(context),
                                formKey: formKey,
                                recieveTime: orderModel.recieveTime,
                                changeDate: isReadOnly
                                    ? null
                                    : (date) {
                                        onChangeDate(date);
                                      })),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomColumnWithTextInAddNewType(
                      text: "ملاحظات",
                      textLabel: "",
                      readOnly: isReadOnly,
                      textInnerStyle: AppFontStyles.bold16(context),
                      enableBorder: true,
                      maxLine: 5,
                      controller:
                          TextEditingController(text: orderModel.notice),
                      onChanged: (value) {
                        onChangeNotice(value);
                      },
                      textStyle: AppFontStyles.bold16(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
