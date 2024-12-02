import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/analysis_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_analysis.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_of_analysis.dart';
import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView(
      {super.key,
      required this.analysisModelData,
      required this.changeStartDate,
      required this.changeEndDate,
      required this.isLoading,
      required this.onTap,
      this.startDate,
      this.endDate,
      required this.makeAnalysis});
  final AnalysisModelData? analysisModelData;
  final void Function(DateTime) changeStartDate;
  final void Function(DateTime) changeEndDate;
  final void Function(int,{required String type}) onTap;
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function() makeAnalysis;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "حدد الفترة الزمنية",
              style: AppFontStyles.extraBold35(context),
            ),
            const SizedBox(
              height: 24,
            ),
            HeaderOfAnalysis(
              startDate: startDate,
              endDate: endDate,
              changeStartDate: (start) {
                changeStartDate(start);
              },
              changeEndDate: (end) {
                changeEndDate(end);
              },
              makeAnalysis: makeAnalysis,
            ),
            const SizedBox(
              height: 72,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : analysisModelData != null
                    ? ContentOfAnalysis(
                        onTap: (index,{required String type}) {
                          onTap(index,type: type);
                        },
                        analysisModelData: analysisModelData!,
                      )
                    : Center(
                        child: Text(
                          "اختار المدي الزمني لتحليل النتائج ",
                          style: AppFontStyles.extraBold50(context),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
