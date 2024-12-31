import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/analysis_model.dart';
import 'package:flutter/material.dart';

class ContentOfAnalysis extends StatelessWidget {
  const ContentOfAnalysis({
    super.key,
    required this.analysisModelData,
    required this.onTap,
  });
  final AnalysisModelData analysisModelData;
  final void Function(int index, {required String type}) onTap;

  @override
  Widget build(BuildContext context) {
    List<AnalysisModel> analysisList = getAnalysisList(analysisModelData);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing:20,
        spacing: getAdaptiveSpacing(context),
        children: [
          ...List.generate(analysisList.length, (index) {
            return FittedBox(
              child: CustomPushContainerButton(
                borderRadius: 12,
                padding: EdgeInsets.symmetric(
                    horizontal: getAdaptiveSpacing(context), vertical: 12),
                color: analysisList[index].color,
                childInstead: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            analysisList[index].title,
                            style: contentInAnalysisItem(context),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              analysisList[index].iconData,
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${analysisList[index].moneyQuantity} جنية",
                            style: contentInAnalysisItem(context,
                                letterSpacing: 3),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              onTap(analysisList[index].index,
                                  type: analysisList[index].title);
                            },
                            tooltip: "عرض كل التفاصيل",
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.white,
                              size: 33,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

TextStyle contentInAnalysisItem(BuildContext context, {double? letterSpacing}) {
  if (AppFontsLayout.isMobile(context)) {
    return AppFontStyles.extraBold14(context)
        .copyWith(color: AppColors.white, letterSpacing: letterSpacing);
  } else if (AppFontsLayout.isTablet(context)) {
    return AppFontStyles.extraBoldNew20(context)
        .copyWith(color: AppColors.white, letterSpacing: letterSpacing);
  } else if (AppFontsLayout.isDesktop(context)) {
    return AppFontStyles.extraBoldNew28(context)
        .copyWith(color: AppColors.white, letterSpacing: letterSpacing);
  } else {
    return AppFontStyles.meduim12(context); // Fallback
  }
}

double getAdaptiveSpacing(BuildContext context) {
  if (AppFontsLayout.isMobile(context)) {
    return 16;
  } else if (AppFontsLayout.isTablet(context)) {
    return 24;
  } else if (AppFontsLayout.isDesktop(context)) {
    return 36;
  } else {
    return 20;
  }
}
