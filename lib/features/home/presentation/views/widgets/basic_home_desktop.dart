import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/financial_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/gallery_view.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/management_view.dart';
import 'package:flutter/material.dart';

class BasicHomeWithDiffrentLayOut extends StatelessWidget {
  const BasicHomeWithDiffrentLayOut({
    super.key,
    required this.currIndex,
    required this.changeIndex,
  });

  final int currIndex;
  final void Function(int) changeIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAdaptiveLayout(
          desktopLayout: (context,[constraint]) => CustomAppBar(
            currIndex: currIndex,
            changeIndex: (pageIndex) {
              changeIndex(pageIndex);
            },
          ),
          mobileLayout: (context) => const SizedBox(),
          tabletLayout: (context,[constraint]) => CustomAppBar(
            textStyle: AppFontStyles.extraBoldNew24(context).copyWith(color: AppColors.white),
            currIndex: currIndex,
            enableLogo: false,
            changeIndex: (pageIndex) {
              changeIndex(pageIndex);
            },
          ),
        ),
        [
          const GalleryView(),
          const ManagementView(),
          const FinancialView(),
        ][currIndex],
      ],
    );
  }
}
