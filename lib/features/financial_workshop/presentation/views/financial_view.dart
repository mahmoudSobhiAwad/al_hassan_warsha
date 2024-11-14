import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/side_bar_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/analysis_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/custom_side_bar_item.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/financial_body.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/pill_payment_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_view.dart';
import 'package:flutter/material.dart';

class FinancialView extends StatefulWidget {
  const FinancialView({super.key});

  @override
  State<FinancialView> createState() => _FinancialViewState();
}

class _FinancialViewState extends State<FinancialView> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: const BoxDecoration(color: AppColors.veryLightGray2),
              child: CustomScrollView(
                slivers: [
                  SliverList.separated(
                      itemCount: financialSideBarList.length,
                      itemBuilder: (context, index) {
                        return CustomFinancialSideBarItem(
                          model: financialSideBarList[index],
                          onTap: () {
                            currIndex = index;
                            setState(() {});
                          },
                          picked: currIndex == index,
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
        Expanded(
          flex: 5,
          child: const [
            FinancialBody(),
            TranscationView(),
            BillsPaymentView(),
            AnalysisView(),
          ][currIndex],
        )
      ]),
    );
  }
}




