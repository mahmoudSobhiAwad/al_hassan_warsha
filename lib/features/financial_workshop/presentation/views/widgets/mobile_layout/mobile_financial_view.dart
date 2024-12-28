import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/customer_bill_mobile_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/side_bar_financial.dart';
import 'package:flutter/material.dart';

class MobileFinancialView extends StatelessWidget {
  const MobileFinancialView({super.key, required this.bloc});
  final FinanicalBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "النظام المالي",
          openDrawer: () {
            bloc.add(ChangeSideBarActiveEvent(isActiveState: true));
          },
          enableActionButton: false,
        ),
        bloc.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: Stack(
                  children: [
                    PageView(
                      children: [
                        CustomerBillsMobileView(bloc: bloc),
                      ],
                    ),
                    if (bloc.isSideBarActive)
                      SideBarInFinancial(
                        width: context.screenWidth * 0.5,
                        changeIndex: (index) {
                          bloc.add(ChangeCurrentIndexEvent(index: index));
                        },
                        currIndex: bloc.currIndex,
                        widget: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                bloc.add(ChangeSideBarActiveEvent(
                                    isActiveState: false));
                              },
                              icon: const Icon(Icons.close)),
                        ),
                      ),
                  ],
                ),
              ),
      ],
    );
  }
}
