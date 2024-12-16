import 'dart:async';

import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/edit_order_body.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/edit_order_view_mobile.dart';
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
                body: CustomAdaptiveLayout(
                    desktopLayout: (context) {
                      return Column(
                        children: [
                          AppBarWithLinking(items: [
                            "تعديل طلب ",
                            orderModel.orderName,
                          ]),
                          EditOrderBody(orderModel: orderModel, bloc: bloc),
                        ],
                      );
                    },
                    mobileLayout: (context) {
                      return  EditOrderViewMobile(orderModel: orderModel, bloc: bloc);
                    },
                    tabletLayout: (context) => const Text("Tablet")),
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
