import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_time_picker.dart';
import 'package:al_hassan_warsha/features/financial_workshop/presentation/views/widgets/content_analysis.dart';
import 'package:flutter/material.dart';

class HeaderOfAnalysis extends StatelessWidget {
  const HeaderOfAnalysis({
    super.key,
    required this.changeStartDate,
    required this.changeEndDate,
    this.startDate,
    this.endDate,
    required this.makeAnalysis,
  });
  final void Function(DateTime) changeStartDate;
  final void Function(DateTime) changeEndDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function() makeAnalysis;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: CustomDatePicker(
            isReadOnly: false,
            labelText: "البداية",
            recieveTime: startDate,
            changeDate: changeStartDate,
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: CustomDatePicker(
            isReadOnly: false,
            startDate: startDate,
            labelText: "النهاية",
            recieveTime: endDate,
            changeDate:startDate!=null? changeEndDate:(d){},
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
         Expanded(
            flex: 4,
            child: CustomPushContainerButton(
              pushButtomText: "بحث",
              pushButtomTextFontSize: contentInAnalysisItem(context).fontSize,
              onTap: makeAnalysis,
              iconBehind: Icons.search,
              padding:const EdgeInsets.symmetric(vertical: 8),
              borderRadius: 12,
              iconSize: 30,
            )),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
