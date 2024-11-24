import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/action_types_in_dialog.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/alert_to_check_db.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:flutter/material.dart';

class PopMenuActionBehindEachOrder extends StatelessWidget {
  const PopMenuActionBehindEachOrder({
    super.key,
    required this.orderList,
    required this.bloc,
    required this.currIndex,
  });

  final List<OrderModel> orderList;
  final ManagementBloc bloc;
  final int currIndex;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MoreVertAction>(
      color: AppColors.veryLightGray2,
      itemBuilder: (context) {
        return [
          ...List.generate(
              4,
              (indexOf) => PopupMenuItem(
                  onTap: () {
                    switch (moreVerList(
                            orderList[currIndex].orderStatus!)[indexOf]
                        .moreVertEnum) {
                      case MoreVertAction.edit:
                       
                        bloc.add(NavToEditEvent(
                            orderModel: orderList[currIndex]));
                        break;
                      case MoreVertAction.delete:
                       
                        showDialog(
                            context: context,
                            useSafeArea: true,
                            builder: (context) {
                              return Dialog(
                                child: CustomAlert(
                                  title:
                                      "هل أنت متأكد من حذف هذا الطلب ؟",
                                  enableIcon: false,
                                  actionButtonsInstead:
                                      DialogAddNewTypeActionButton(
                                    onPressed_1: () {
                                      Navigator.pop(context);
                                      bloc.add(DeleteOrderEvent(
                                          mediaList: orderList[currIndex]
                                              .mediaOrderList,
                                          orderId: orderList[currIndex]
                                              .orderId));
                                    },
                                    onPressed_2: () {
                                      Navigator.pop(context);
                                    },
                                    text_1: "حذف",
                                    text_2: "إلغاء",
                                    color_1: AppColors.red,
                                    color_2: AppColors.green,
                                  ),
                                ),
                              );
                            });
                      case MoreVertAction.viewProfile:
                        
                        break;
                      case MoreVertAction.deliver:
                        
                        bloc.add(MarkOrderAsDelievredEvent(
                            orderId: orderList[currIndex].orderId,
                            makeItDone: true));
                        break;
                      case MoreVertAction.notDeliever:
                       
                        bloc.add(MarkOrderAsDelievredEvent(
                            orderId: orderList[currIndex].orderId,
                            makeItDone: false));
                        break;
                    }
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(moreVerList(orderList[currIndex]
                                .orderStatus!)[indexOf]
                            .icon),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(moreVerList(orderList[currIndex]
                                .orderStatus!)[indexOf]
                            .text),
                      ],
                    ),
                  )))
        ];
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
