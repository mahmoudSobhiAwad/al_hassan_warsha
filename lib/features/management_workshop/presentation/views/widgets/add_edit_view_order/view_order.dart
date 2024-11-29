import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/view_profile_for_customer.dart';
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
      listener: (context, state) {
        if (state is DeletedOrderSuccessState) {
          Navigator.pop(context);
          showCustomSnackBar(
            context,
            "تم الحذف بنجاح",
          );
        } else if (state is DeletedOrderFailureState) {
          showCustomSnackBar(context, state.errMessage ?? "",
              backgroundColor: AppColors.red);
        } else if (state is MakeOrderDeliverOrNotSuccessState) {
          Navigator.pop(context);
          showCustomSnackBar(context, state.successMessage ?? "");
        } else if (state is SuccessGetCustomerProfileState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerProfileView(
                      model: state.customerModel, bloc: bloc)));
        }
      },
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
                ShowOneOrderBody(
                  navToProfileView: (customerId) {
                    bloc.add(GetCustomerProfileEvent(customerId: customerId));
                  },
                  markAsDone: (orderId, check) {
                    bloc.add(MarkOrderAsDelievredEvent(
                        orderId: orderId, makeItDone: check));
                  },
                  deleteOrder: (orderId, list) {
                    bloc.add(
                        DeleteOrderEvent(mediaList: list, orderId: orderId));
                  },
                  orderModel: orderModel,
                  navToEdit: (model) {
                    bloc.add(NavToEditEvent(orderModel: model));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
