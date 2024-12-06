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
  });
  final String title;
  final bool enableDrawer;

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
              ? const IconButton(
                  onPressed: null, icon: Icon(FontAwesomeIcons.bars))
              : const SizedBox(),
          Text(
            title,
            style: AppFontStyles.extraBold32(context),
          ),
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: IconButton(onPressed: null, icon: Icon(Icons.create))),
          )
        ],
      ),
    );
  }
}