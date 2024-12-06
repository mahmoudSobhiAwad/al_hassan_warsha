import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:flutter/material.dart';

class ManagmentMobileView extends StatelessWidget {
  const ManagmentMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomMobileAppBar(title: "إدراة الورشة",enableDrawer: false,),
      ],
    );
  }
}