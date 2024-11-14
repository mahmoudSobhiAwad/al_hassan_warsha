import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_for_payment_bills.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_pill_payment.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/title_pill_payment.dart';
import 'package:flutter/material.dart';

class BillsPaymentView extends StatelessWidget {
  const BillsPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          const SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomPushContainerButton(
                pushButtomText: " تعديل المرتبات",
                borderRadius: 12,
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                iconBehind: Icons.mode_edit_outline_rounded,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 36,
            ),
          ),
          const SliverToBoxAdapter(
            child: TitleInBillPayment(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),
          const SliverToBoxAdapter(
            child: HeaderForBillsPayment(),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              return const ContentForBillsPayment();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: 5,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(child: CustomPushContainerButton(color: AppColors.green,pushButtomText: "دفع المرتبات المحددة",padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),borderRadius: 12,enableIcon: false,)),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
