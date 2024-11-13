import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/add_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_in_transaction_history.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_transaction.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';

class TranscationView extends StatelessWidget {
  const TranscationView({super.key});

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
          const AddTransaction(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(
                child: CustomPushContainerButton(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              pushButtomText: "إضافة تحويل",
              color: AppColors.green,
              borderRadius: 12,
            )),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),),
          const SliverToBoxAdapter(
            child: FilterOrdersWithMonthYear(title: "تاريخ التحويلات",),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 35,
            ),),
          const SliverToBoxAdapter(
            child: HeaderForTransactionHistory()
          ),
          const SliverToBoxAdapter(
            child:  SizedBox(
              height: 16,
            ),),
            SliverList.separated(
              itemCount: 10,
              itemBuilder: (context,index){  
              return const ContentInTransactionHistory();
            }, separatorBuilder: (context,index){
              return const SizedBox(height: 16,);
            }),
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
