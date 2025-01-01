import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DialogTitleWithNav extends StatelessWidget {
  const DialogTitleWithNav({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Text(
          title,
          style: AppFontStyles.bold16(context),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              FontAwesomeIcons.circleXmark,
              color: AppColors.red,
            ))
      ],
    );
  }
}
