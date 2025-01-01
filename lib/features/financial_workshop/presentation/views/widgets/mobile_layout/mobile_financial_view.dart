import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/analysis_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/customer_bill_mobile_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/transaction_history_mobile.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/workers_management_mobile.dart';
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
            bloc.add(
                ChangeSideBarActiveEvent(isActiveState: !bloc.isSideBarActive));
          },
          enableActionButton: false,
        ),
        bloc.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return [
                            CustomerBillsMobileView(bloc: bloc),
                            TransactionHistoryMobile(
                              bloc: bloc,
                            ),
                            SalaryForWorkersMobileLayOut(
                              bloc: bloc,
                            ),
                            AnalysisView(
                              onTap: (index, {required String type}) {
                                bloc.add(NavToAnlysisListEvent(
                                    index: index, type: type));
                              },
                              analysisModelData: bloc.analysisModelData,
                              startDate: bloc.startDate,
                              endDate: bloc.endDate,
                              changeStartDate: (start) {
                                bloc.add(ChangeStartOrEndDateEvent(
                                    startDate: start));
                              },
                              changeEndDate: (end) {
                                bloc.add(
                                    ChangeStartOrEndDateEvent(endDate: end));
                              },
                              makeAnalysis: () {
                                bloc.add(MakeAnalysisEvent());
                              },
                              isLoading: bloc.isAnalysisLoading,
                            ),
                          ][bloc.currIndex];
                        }),
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
