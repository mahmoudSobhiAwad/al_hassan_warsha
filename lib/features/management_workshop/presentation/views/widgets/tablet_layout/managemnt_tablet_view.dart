import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class ManagemntTabletView extends StatelessWidget {
  const ManagemntTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("ادارة الورشة  ",style: AppFontStyles.extraBold32(context),)
      ],
    );
  }
}