import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/add_transaction.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_in_transaction_history.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_transaction.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';

class TranscationView extends StatefulWidget {
  const TranscationView({super.key});

  @override
  State<TranscationView> createState() => _TranscationViewState();
}

class _TranscationViewState extends State<TranscationView> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
            ),
          ),
           SliverToBoxAdapter(
            child: FilterOrdersWithMonthYear(
              title: "تاريخ التحويلات", changeMonth: (month ) {  }, searchFor: () {  }, changeYear: (time ) {  },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 35,
            ),
          ),
          const SliverToBoxAdapter(child: HeaderForTransactionHistory()),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Expanded(child: SizedBox(),),
                Expanded(
                  flex: 11,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: Scrollbar(
                      thickness: 20,
                      thumbVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      controller: controller,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            controller: controller,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const ContentInTransactionHistory();
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox(),),
              ],
            ),
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
