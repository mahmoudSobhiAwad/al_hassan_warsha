import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/one_table_content.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/table_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class FinancialBody extends StatefulWidget {
  const FinancialBody({
    super.key,
  });

  @override
  State<FinancialBody> createState() => _FinancialBodyState();
}

class _FinancialBodyState extends State<FinancialBody> {
  final ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: Scrollbar(
                controller: scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: 20,
                thumbVisibility: true,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ContentOfFinancialTable();
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                          padding: EdgeInsets.only(bottom: 16));
                    },
                  ),
                ),
              ),
            ),
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
