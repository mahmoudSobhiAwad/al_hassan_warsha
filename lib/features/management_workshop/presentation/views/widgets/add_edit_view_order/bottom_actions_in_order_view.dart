import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';


class BottomActionOrderInViewOrder extends StatelessWidget {
  const BottomActionOrderInViewOrder({
    super.key,
    required this.orderModel,
    required this.markAsDone,
    required this.deleteOrder,
    required this.isLoading,
    this.fontSize,
  });

  final OrderModel orderModel;
  final void Function(String, bool) markAsDone;
  final void Function(String, List<MediaOrderModel>) deleteOrder;
  final bool isLoading;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return orderModel.orderStatus != OrderStatus.finished
        ? DialogAddNewTypeActionButton(
            text_1: " تسليم الطلب",
            fontSize: fontSize,
            onPressed_1: () {
              markAsDone(orderModel.orderId, true);
            },
            text_2: "حذف الطلب",
            onPressed_2: () {
              showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (context) {
                    return Dialog(
                      child: CustomAlert(
                        title: "هل أنت متأكد من حذف هذا الطلب ؟",
                        enableIcon: false,
                        actionButtonsInstead: DialogAddNewTypeActionButton(
                          onPressed_1: () {
                            Navigator.pop(context);
                            deleteOrder(
                                orderModel.orderId, orderModel.mediaOrderList);
                          },
                          onPressed_2: () {
                            Navigator.pop(context);
                          },
                          instead_1: isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text("حذف",
                                  style: AppFontStyles.extraBoldNew24(context)
                                      .copyWith(
                                    color: AppColors.white,
                                  )),
                          text_2: "إلغاء",
                          color_1: AppColors.red,
                          color_2: AppColors.green,
                        ),
                      ),
                    );
                  });
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
              pushButtomText: " تمييز كغير مستلم",
            ),
          );
  }
}
