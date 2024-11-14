import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_for_payment_bills.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_pill_payment.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/title_pill_payment.dart';
import 'package:flutter/material.dart';

class BillsPaymentView extends StatefulWidget {
  const BillsPaymentView({super.key});

  @override
  State<BillsPaymentView> createState() => _BillsPaymentViewState();
}

class _BillsPaymentViewState extends State<BillsPaymentView> {
  final ScrollController scrollController = ScrollController();
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
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 11,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.veryLightGray, width: 2),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: 300,
                    child: Scrollbar(
                      controller: scrollController,
                      thickness: 20,
                      radius: const Radius.circular(10),
                      thumbVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false,),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return ContentForBillsPayment(
                              allowDivder: index == 2,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: 4,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(
                child: CustomPushContainerButton(
              color: AppColors.green,
              pushButtomText: "دفع المرتبات المحددة",
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 12,
              enableIcon: false,
            )),
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
