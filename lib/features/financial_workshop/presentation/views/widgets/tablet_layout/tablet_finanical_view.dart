import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class TabletFinanicalView extends StatelessWidget {
  const TabletFinanicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("هنا النظام المالي ",style: AppFontStyles.extraBold40(context),)
      ],
    );
  }
}