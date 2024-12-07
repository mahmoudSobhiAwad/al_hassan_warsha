import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavBarForPhone extends StatelessWidget {
  const CustomBottomNavBarForPhone({
    super.key,
    required this.changePage,
    required this.currIndex,
  });

  final void Function(int) changePage;
  final int currIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColors.darkBlue,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.lightGray1,
        onTap: (index) {
          changePage(index);
        },
        elevation: 0,
        selectedLabelStyle: AppFontStyles.extraBoldNew16(context),
        unselectedLabelStyle: AppFontStyles.extraBoldNew14(context),
        currentIndex: currIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined), label: "المعرض"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: "ادارة الورشة"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.database), label: "النظام المالي"),
        ]);
  }
}
