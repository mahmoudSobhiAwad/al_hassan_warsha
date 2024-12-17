import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/custom_page_view_list_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/nex_back_buttons.dart';
import 'package:flutter/material.dart';

class EditOrderViewMobile extends StatelessWidget {
  const EditOrderViewMobile(
      {super.key, required this.bloc, required this.orderModel});
  final ManagementBloc bloc;
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "تعديل الطلب",
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            bloc.add(SetCurrPageIndexToZero());
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: CustomPageViewInViewOrderMobile(
            bloc: bloc,
            isEdit: true,
            isReadOnly: false,
            orderModel: orderModel,
            bottomOrderAction: Center(
              child: CustomPushContainerButton(
                childInstead: bloc.isLoadingActionsOrder
                    ? const CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "تعديل ",
                            style: AppFontStyles.extraBoldNew24(context)
                                .copyWith(color: AppColors.white),
                          ),
                          const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.white,
                                size: 30,
                              ))
                        ],
                      ),
                onTap: () {
                  if (bloc.fromKeyThirdPageEdit.currentState!.validate()) {
                    bloc.add(EditOrderEvent());
                  }
                },
                borderRadius: 14,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        NextPageOrBackButtons(
          currPageIndex: bloc.currPageMobile,
          nextOrBack: (stauts) {
            if (bloc.currPageMobile == 0) {
              if (stauts && bloc.fromKeyEdit.currentState!.validate()) {
                bloc.add(
                    ChangeCurrPageInMobile(isForward: stauts, isEdit: true));
              }
            } else {
              bloc.add(ChangeCurrPageInMobile(isForward: stauts, isEdit: true));
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
