import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/view_order_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowOneOrderView extends StatelessWidget {
  const ShowOneOrderView(
      {super.key, required this.bloc, required this.orderModel});
  final ManagementBloc bloc;
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {},
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWithLinking(
                  items: [
                    "إدارة الورشة",
                    orderModel.orderName,
                  ],
                ),
                ShowOneOrderBody(orderModel: orderModel)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

