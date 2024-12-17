import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_new_order_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/custom_page_view_list_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/nex_back_buttons.dart';
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
            bloc.currPageMobile = 0;
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: CustomPageViewInViewOrderMobile(
            customerModel: customerModel,
            bloc: bloc,
            bottomOrderAction: AddNewOrderButton(
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textStyle: AppFontStyles.bold18(context)
                    .copyWith(color: AppColors.white),
                formKey: bloc.fromKeyThirdPage,
                addOrder: () {
                  bloc.add(AddNewOrderEvent(customerModel: customerModel));
                },
                isLoading: bloc.isLoadingActionsOrder),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        NextPageOrBackButtons(
          currPageIndex: bloc.currPageMobile,
          nextOrBack: (stauts) {
            if (bloc.currPageMobile == 0) {
              if (stauts && bloc.fromKey.currentState!.validate()) {
                bloc.add(ChangeCurrPageInMobile(isForward: stauts));
              }
            } else {
              bloc.add(ChangeCurrPageInMobile(isForward: stauts));
            }
          },
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
