import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/manager/bloc/management_bloc.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/add_new_order_button.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/custom_page_view_list_mobile.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/mobile_layout/nex_back_buttons.dart';
import 'package:flutter/material.dart';

class AddOrderViewMobile extends StatefulWidget {
  const AddOrderViewMobile({super.key, required this.bloc, this.customerModel});
  final ManagementBloc bloc;
  final CustomerModel? customerModel;

  @override
  State<AddOrderViewMobile> createState() => _AddOrderViewMobileState();
}

class _AddOrderViewMobileState extends State<AddOrderViewMobile> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "اضافة طلب جديد",
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            widget.bloc.add(SetCurrPageIndexToZero());
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: CustomPageViewInViewOrderMobile(
            customerModel: widget.customerModel,
            bloc: widget.bloc,
            bottomOrderAction: AddNewOrderButton(
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textStyle: AppFontStyles.bold18(context)
                    .copyWith(color: AppColors.white),
                formKey: widget.bloc.fromKeyThirdPage,
                addOrder: () {
                  widget.bloc.add(
                      AddNewOrderEvent(customerModel: widget.customerModel));
                },
                isLoading: widget.bloc.isLoadingActionsOrder),
            pageController:_pageController,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        NextPageOrBackButtons(
          currPageIndex: widget.bloc.currPageMobile,
          nextOrBack: (stauts) {
            if (widget.bloc.currPageMobile == 0) {
              if (stauts &&
                  widget.bloc.fromKeyFirstPage.currentState!.validate()) {
                widget.bloc.add(ChangeCurrPageInMobile(isForward: stauts,controller: _pageController));
              }
            } else {
              widget.bloc.add(ChangeCurrPageInMobile(isForward: stauts,controller: _pageController));
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
