import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/side_bar_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/analysis_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/custom_side_bar_item.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/financial_body.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/salary_widget/add_edit_salary.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/tablet_layout/table_side_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_view.dart';
import 'package:flutter/material.dart';

class FinancialDesktopLayOuts extends StatelessWidget {
  const FinancialDesktopLayOuts({
    super.key,
    required this.bloc,
    this.isTabletLayOut = false,
  });

  final FinanicalBloc bloc;
  final bool isTabletLayOut;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      isTabletLayOut
          ? SideBarFinancialInTabletLayOut(
            isSideBarActive: bloc.isSideBarActive,
            enableOrDisableSideBar: (status){
              bloc.add(ChangeSideBarActiveEvent(isActiveState: status));
            },
              onPressed: (activeIndex) {
                bloc.add(ChangeCurrentIndexEvent(index: activeIndex));
              },
              activeIndex: bloc.currIndex)
          : Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration:
                    const BoxDecoration(color: AppColors.veryLightGray2),
                child: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverList.separated(
                        itemCount: financialSideBarList.length,
                        itemBuilder: (context, index) {
                          return CustomFinancialSideBarItem(
                            model: financialSideBarList[index],
                            onTap: () {
                              bloc.add(ChangeCurrentIndexEvent(index: index));
                            },
                            picked: bloc.currIndex == index,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 24,
                          );
                        })
                  ],
                ),
              )),
      bloc.isLoading
          ? const Expanded(
              flex: 5,
              child:
                  SizedBox(child: Center(child: CircularProgressIndicator())))
          : Expanded(
              flex: 5,
              child: [
                FinancialBody(
                  isTabletLayOut: isTabletLayOut,
                  bloc: bloc,
                ),
                TranscationView(
                  bloc: bloc,
                ),
                AddEditSalaryView(
                  bloc: bloc,
                ),
                AnalysisView(
                  onTap: (index, {required String type}) {
                    bloc.add(NavToAnlysisListEvent(index: index, type: type));
                  },
                  analysisModelData: bloc.analysisModelData,
                  startDate: bloc.startDate,
                  endDate: bloc.endDate,
                  changeStartDate: (start) {
                    bloc.add(ChangeStartOrEndDateEvent(startDate: start));
                  },
                  changeEndDate: (end) {
                    bloc.add(ChangeStartOrEndDateEvent(endDate: end));
                  },
                  makeAnalysis: () {
                    bloc.add(MakeAnalysisEvent());
                  },
                  isLoading: bloc.isAnalysisLoading,
                ),
              ][bloc.currIndex],
            )
    ]);
  }
}
