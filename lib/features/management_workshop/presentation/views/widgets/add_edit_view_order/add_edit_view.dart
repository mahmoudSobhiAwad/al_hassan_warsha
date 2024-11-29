import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_body.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/view_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditViewOrder extends StatelessWidget {
  const AddEditViewOrder({super.key, required this.bloc, this.model});
  final ManagementBloc bloc;
  final CustomerModel? model;
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
                  const AppBarWithLinking(
                      items: ["إدارة الورشة", "اضافة عمل جديد"]),
                  AddOrderBody(
                    bloc: bloc,
                    model: model,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessAddNewOrderState) {
          showCustomSnackBar(context, "تمت اضافة الطلب بنجاح ");
          model != null
              ? Navigator.pop(context)
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowOneOrderView(
                          bloc: bloc, orderModel: state.lastAdded)));
        } else if (state is FailureAddNewOrderState) {
          showCustomSnackBar(context, state.errMessage ?? "");
        }
      },
    );
  }
}
