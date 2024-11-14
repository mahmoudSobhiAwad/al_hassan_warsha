import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_analysis.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/header_of_analysis.dart';
import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("حدد الفترة الزمنية",style: AppFontStyles.extraBold35(context),),
            const SizedBox(
              height: 24,
            ),
            const HeaderOfAnalysis(),
            const SizedBox(
              height: 72,
            ),
            const ContentOfAnalysis(),
          ],
        ),
      ),
    );
  }
}