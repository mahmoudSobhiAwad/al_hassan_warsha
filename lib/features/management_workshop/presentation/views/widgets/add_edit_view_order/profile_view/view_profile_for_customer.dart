import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/customer_profile_body.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/mobile_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProfileView extends StatelessWidget {
  const CustomerProfileView(
      {super.key, required this.model, required this.bloc});
  final CustomerModel model;
  final ManagementBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listener: (context, state) {
          if (state is SuccessStepDownMoneyState) {
            model.orderModelList
                .firstWhere((model) => model.orderId == state.pillModel.orderId)
                .pillModel = state.pillModel;
            showCustomSnackBar(context, "تم تنزيل دفعة بنجاح ");
          } else if (state is FailureStepDownMoneyState) {
            showCustomSnackBar(context, state.errMessage ?? "",
                backgroundColor: AppColors.red);
          } else if (state is SuccessAddNewOrderState) {
            model.orderModelList.add(state.lastAdded);
          } else if (state is FailureAddNewOrderState) {
            showCustomSnackBar(context, "${state.errMessage}",
                backgroundColor: AppColors.red);
          }
        },
        bloc: bloc,
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.white,
                  body: CustomAdaptiveLayout(desktopLayout: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppBarWithLinking(
                            items: ["إدارة الورشة", "عرض ملف شخصي"]),
                        CustomerProfileBody(bloc: bloc, model: model),
                      ],
                    );
                  }, mobileLayout: (context) {
                    return MobileProfileView(
                      customerModel: model,
                      stepDown: (pill) {
                        bloc.add(StepDownMoneyEvent(pillModel: pill));
                      },
                      addNewOrder: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOrderView(
                              bloc: bloc,
                              model: model,
                            ),
                          ),
                        );
                      },
                      navigteToEdit: (model) {
                        bloc.add(NavToEditEvent(orderModel: model));
                      },
                    );
                  }, tabletLayout: (context) {
                    return const Text("Tabelt is Here");
                  })),
            ),
          );
        });
  }
}
