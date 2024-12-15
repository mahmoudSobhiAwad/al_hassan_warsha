import 'package:al_hassan_warsha/core/utils/widgets/custom_mobile_app_bar.dart';
import 'package:flutter/material.dart';

class EditOrderViewMobile extends StatelessWidget {
  const EditOrderViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMobileAppBar(
          title: "تعديل الطلب",
          drawerIconInstead: Icons.arrow_back_ios_rounded,
          enableActionButton: false,
          openDrawer: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
