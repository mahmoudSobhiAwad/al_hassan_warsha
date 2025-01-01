import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_snack_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo_impl.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/manager/bloc/finanical_bloc.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/financial_desktop.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/mobile_layout/mobile_financial_view.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/transaction_after_analysis/transactions_after_analysis_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialView extends StatelessWidget {
  const FinancialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FinanicalBloc(financialRepoImpl: getIt.get<FinancialRepoImpl>())
            ..add(FetchAllOrderWithThierBillEvent()),
      child: BlocConsumer<FinanicalBloc, FinanicalState>(
          listener: (context, state) {
        var bloc = context.read<FinanicalBloc>();
        if (state is SuccessUpdateCounterOrderState) {
          showCustomSnackBar(context, "تم تنزيل دفعة بنجاح ");
        } else if (state is SuccessAddTransactionState) {
          showCustomSnackBar(context, "تم ادراج التحويل بنجاح ");
        } else if (state is SuccessPayAllSalariesWorkersState) {
          showCustomSnackBar(context, "تم دفع المرتبات بنجاح ");
        } else if (state is FailureFetchOrderState) {
          showCustomSnackBar(context, "${state.errMessage}",
              backgroundColor: AppColors.red);
        } else if (state is FailureUpdateCounterOrderState) {
          showCustomSnackBar(context, "${state.errMessage}",
              backgroundColor: AppColors.red);
        } else if (state is SuccessAddTransactionState) {
          showCustomSnackBar(context, "تم اضافة التحويل بنجاح ");
        } else if (state is FailureEditWorkersData) {
          showCustomSnackBar(context, state.errMessage ?? "",
              backgroundColor: AppColors.orange);
        } else if (state is FailurePayAllSalariesWorkersState) {
          showCustomSnackBar(context, state.errMessage ?? "",
              backgroundColor: AppColors.orange);
        } else if (state is FailureAnalysisState) {
          showCustomSnackBar(context, state.errMessage ?? "",
              backgroundColor: AppColors.orange);
        } else if (state is SuccessEditWorkersData) {
          showCustomSnackBar(
            context,
            "تم تعديل بيانات الموظفين بنجاح",
          );
        } else if (state is NavToAnlysisListState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionsAfterAnalysisView(
                        bloc: bloc,
                        transactionType: state.type,
                        index: state.typedIndex,
                      )));
        }
      }, builder: (context, state) {
        var bloc = context.read<FinanicalBloc>();
        return Expanded(
          child: CustomAdaptiveLayout(
              desktopLayout: (
                context,
              ) =>
                  FinancialDesktopLayOuts(bloc: bloc),
              mobileLayout: (context) => MobileFinancialView(
                    bloc: bloc,
                  ),
              tabletLayout: (
                context,
              ) =>
                  FinancialDesktopLayOuts(
                    bloc: bloc,
                    isTabletLayOut: true,
                  )),
        );
      }),
    );
  }
}
