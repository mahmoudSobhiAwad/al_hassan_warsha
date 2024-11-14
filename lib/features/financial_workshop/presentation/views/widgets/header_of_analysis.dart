import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class HeaderOfAnalysis extends StatelessWidget {
  const HeaderOfAnalysis({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              text: "البداية",
              textLabel: "",
              enableBorder: true,
              suffixIcon: const Icon(Icons.calendar_month),
              textStyle: AppFontStyles.extraBold18(context),
            )),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              text: "النهاية",
              textLabel: "",
              enableBorder: true,
              suffixIcon: const Icon(Icons.calendar_month),
              textStyle: AppFontStyles.extraBold18(context),
            )),
        const Expanded(flex: 1, child: SizedBox()),
        const Expanded(
            flex: 2,
            child: CustomPushContainerButton(
              pushButtomText: "بحث",
              iconBehind: Icons.search,
              padding: EdgeInsets.symmetric(vertical: 8),
              borderRadius: 12,
              iconSize: 30,
            )),
        const Expanded(flex: 2, child: SizedBox()),
      ],
    );
  }
}
