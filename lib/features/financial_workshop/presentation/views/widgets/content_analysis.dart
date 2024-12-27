import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/analysis_model.dart';
import 'package:flutter/material.dart';

class ContentOfAnalysis extends StatelessWidget {
  const ContentOfAnalysis({
    super.key,
    required this.analysisModelData,
    required this.onTap,
    this.isTabletLayOut = false,
  });
  final AnalysisModelData analysisModelData;
  final void Function(int index, {required String type}) onTap;
  final bool isTabletLayOut;

  @override
  Widget build(BuildContext context) {
    List<AnalysisModel> analysisList = getAnalysisList(analysisModelData);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Wrap(
        runSpacing:isTabletLayOut?20: 40,
        spacing: 46,
        children: [
          ...List.generate(analysisList.length, (index) {
            return FittedBox(
              child: CustomPushContainerButton(
                borderRadius: 12,
                padding: EdgeInsets.symmetric(
                    horizontal: isTabletLayOut ? 20 : 65, vertical: 12),
                color: analysisList[index].color,
                childInstead: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            analysisList[index].title,
                            style: AppFontStyles.extraBoldNew28(context)
                                .copyWith(color: AppColors.white,fontSize: isTabletLayOut?20:null),
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
                            style: AppFontStyles.extraBoldNew28(context)
                                .copyWith(
                                    color: AppColors.white, letterSpacing: 3,fontSize: isTabletLayOut?20:null),
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
