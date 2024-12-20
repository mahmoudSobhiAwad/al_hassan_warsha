import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_order_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/customer_info.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/profile_view/order_pages.dart';
import 'package:flutter/material.dart';

class CustomerProfileBody extends StatelessWidget {
  const CustomerProfileBody({
    super.key,
    required this.bloc,
    required this.model,
  });

  final ManagementBloc bloc;
  final CustomerModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        radius: const Radius.circular(5),
        thickness: 12,
        thumbVisibility: true,
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: CustomScrollView(primary: true, slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomPushContainerButton(
                      pushButtomText: 'اضافة طلب جديد',
                      iconBehind: Icons.add,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrderView(
                            bloc: bloc,
                            model: model,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      borderRadius: 14,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomerInfoInOrder(model: model, isReadOnly: true),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "كل الطلبات ",
                        style: AppFontStyles.extraBoldNew24(context),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "( ${model.orderModelList.length} )",
                        style: AppFontStyles.extraBoldNew18(context)
                            .copyWith(color: AppColors.lightGray1),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              OrdersPagesForCustomerView(
                model: model,
                editOrder: (model) {
                  bloc.add(NavToEditEvent(orderModel: model));
                },
                currPage: bloc.currPage,
                stepDown: (pill) {
                  bloc.add(StepDownMoneyEvent(pillModel: pill));
                },
                onChangeCurrPage: (status) {
                  bloc.add(ChangeCurrPageEvent(isForward: status));
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
