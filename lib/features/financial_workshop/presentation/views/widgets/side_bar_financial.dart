import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/side_bar_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/custom_side_bar_item.dart';
import 'package:flutter/material.dart';

class SideBarInFinancial extends StatelessWidget {
  const SideBarInFinancial({
    super.key,
    required this.changeIndex,
    required this.currIndex,
    this.widget,
    this.width
  });

  final int currIndex;
  final void Function(int) changeIndex;
  final Widget?widget;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: const BoxDecoration(color: AppColors.veryLightGray2),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
         if(widget!=null) SliverToBoxAdapter(child: widget,),
          SliverList.separated(
              itemCount: financialSideBarList.length,
              itemBuilder: (context, index) {
                return CustomFinancialSideBarItem(
                  model: financialSideBarList[index],
                  onTap: () {
                    changeIndex(index);
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
    );
  }
}
