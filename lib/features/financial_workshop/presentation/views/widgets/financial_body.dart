import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/one_table_content.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/table_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class FinancialBody extends StatelessWidget {
  const FinancialBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 16,
          )),
          const SliverToBoxAdapter(
            child: SearchBarInManagment(
              enableLastIcon: false,
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 24,
          )),
          const SliverToBoxAdapter(child: TableHeaderInFinancial()),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 10,
          )),
          SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ContentOfFinancialTable();
            },
            separatorBuilder: (context, index) {
              return const Padding(padding: EdgeInsets.only(bottom: 16));
            },
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 16,
          )),
        ],
      ),
    );
  }
}
