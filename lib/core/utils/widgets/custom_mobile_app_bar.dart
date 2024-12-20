import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMobileAppBar extends StatelessWidget {
  const CustomMobileAppBar({
    super.key,
    required this.title,
    this.enableDrawer = true,
    this.openDrawer,
    this.onCreate,
    this.enableActionButton = true,
    this.drawerIconInstead,
  });
  final String title;
  final bool enableDrawer;
  final void Function()? openDrawer;
  final void Function()? onCreate;
  final bool enableActionButton;
  final IconData? drawerIconInstead;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: customLinearGradient(),
      ),
      child: Row(
        children: [
          enableDrawer
              ? IconButton(
                  onPressed: openDrawer,
                  icon: Icon(
                    drawerIconInstead ?? FontAwesomeIcons.bars,
                    color: AppColors.white,
                  ))
              : const SizedBox(),
          Text(
            title,
            style: AppFontStyles.extraBoldNew28(context)
                .copyWith(color: AppColors.white),
          ),
          const Spacer(),
          enableActionButton
              ? Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: IconButton(
                          onPressed: onCreate, icon: const Icon(Icons.create))),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
