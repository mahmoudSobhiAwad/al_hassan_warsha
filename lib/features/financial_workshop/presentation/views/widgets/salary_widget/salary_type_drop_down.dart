import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:flutter/material.dart';

class SalaryTypeDropDown extends StatelessWidget {
  const SalaryTypeDropDown({
    super.key,
    required this.isTabletLayOut,
    required this.salaryType,
    required this.changeSalaryType,
    required this.enableDropDown,
  });

  final bool isTabletLayOut;
  final bool enableDropDown;
  final SalaryType salaryType;
  final void Function(SalaryType type) changeSalaryType;

  @override
  Widget build(BuildContext context) {
    return CustomContainerWithDropDownList(
      primaryStyle: isTabletLayOut
          ? AppFontStyles.bold10(context)
          : AppFontStyles.bold16(context),
      enableDropDwon: enableDropDown,
      primaryText: switch (salaryType) {
        SalaryType.daily => "يومي",
        SalaryType.weekly => "أسبوعي",
        SalaryType.monthly => 'شهري',
      },
      headerText: "نظام القبض",
      onSelected: (model) {
        changeSalaryType(model.valueEnSearh);
      },
      headerStyle: isTabletLayOut
          ? AppFontStyles.bold10(context)
          : AppFontStyles.extraBoldNew14(context),
      dropDownList: [
        SearchModel(valueArSearh: "يومي", valueEnSearh: SalaryType.daily),
        SearchModel(valueArSearh: "أسبوعي", valueEnSearh: SalaryType.weekly),
        SearchModel(valueArSearh: "شهري", valueEnSearh: SalaryType.monthly),
      ],
    );
  }
}
