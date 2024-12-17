import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/tablet_layout/add_order_body_tablet.dart';
import 'package:flutter/material.dart';

class EditOrderTablet extends StatelessWidget {
  const EditOrderTablet({super.key, required this.bloc, required this.model});
  final OrderModel model;
  final ManagementBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWithLinking(
          items: ["إدارة الورشة", "اضافة عمل جديد"],
          fontSize: 22,
        ),
        CustomOrderBodyTablet(
          isEdit: true,
          bottomActionWidget: Center(
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
                if (bloc.fromKeyEdit.currentState!.validate()) {
                  bloc.add(EditOrderEvent());
                }
              },
              borderRadius: 14,
            ),
          ),
          bloc: bloc,
          orderModel: model,
        ),
      ],
    );
  }
}
