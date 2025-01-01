import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_pagination.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_widgets/content_in_transaction_history.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsAfterAnalysisView extends StatelessWidget {
  const TransactionsAfterAnalysisView(
      {super.key,
      required this.transactionType,
      required this.bloc,
      required this.index});
  final String transactionType;
  final int index;
  final FinanicalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: Column(
                  children: [
                    CustomAdaptiveLayout(desktopLayout: (context) {
                      return AppBarWithLinking(items: [
                        "كل التحويلات",
                        transactionType,
                      ]);
                    }, mobileLayout: (context) {
                      return AppBarWithLinking(
                          iconSize: 24,
                          fontSize: 14,
                          items: [
                            "كل التحويلات",
                            transactionType,
                          ]);
                    }, tabletLayout: (context) {
                      return AppBarWithLinking(
                          iconSize: 30,
                          fontSize: 18,
                          items: [
                            "كل التحويلات",
                            transactionType,
                          ]);
                    }),
                    const SizedBox(
                      height: 12,
                    ),
                    bloc.isLoadingFetchAnalysisList
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10),
                              child: Column(
                                children: [
                                  const HeaderForTransactionHistory(
                                    enableLastWidget: false,
                                  ),
                                  bloc.analysisTransactionList.isEmpty
                                      ? Expanded(
                                          child: Center(
                                            child: Text(
                                              "لا يوجد اي معاملات من هذا النوع لهذه الفترة ",
                                              style:
                                                  AppFontStyles.extraBoldNew26(
                                                      context),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Scrollbar(
                                            radius: const Radius.circular(5),
                                            thickness: 12,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            scrollbarOrientation:
                                                ScrollbarOrientation.right,
                                            child: ScrollConfiguration(
                                              behavior: const ScrollBehavior()
                                                  .copyWith(
                                                scrollbars: false,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 20.0),
                                                child: ListView.separated(
                                                    primary: true,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 12),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ContentInTransactionHistory(
                                                        model:
                                                            bloc.analysisTransactionList[
                                                                index],
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const SizedBox(
                                                        height: 20,
                                                      );
                                                    },
                                                    itemCount: bloc
                                                        .analysisTransactionList
                                                        .length),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    bloc.totalLength > 12
                        ? CustomPaginationWidget(
                            length: (bloc.totalLength / 12).ceil(),
                            currentPage: bloc.currPage,
                            onPageChanged: (pageIndex) {
                              bloc.add(ChangeCurrPageEvent(
                                  pageIndex: pageIndex, indexType: index));
                            })
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
