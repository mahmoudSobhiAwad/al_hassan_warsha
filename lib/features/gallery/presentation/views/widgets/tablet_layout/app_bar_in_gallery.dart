import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TypeBarInTabletGallery extends StatelessWidget {
  const TypeBarInTabletGallery({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onTap, icon: const Icon(FontAwesomeIcons.bars)),
          const SizedBox(
            width: 10,
          ),
          Text(
            "انواع المطابخ ",
            style: AppFontStyles.extraBold32(context),
          ),
          const Spacer(),
          const CustomPushContainerButton(
            iconSize: 30,
            pushButtomTextFontSize: 20,
            borderRadius: 12,
            iconBehind: Icons.create,
            padding: EdgeInsets.all(8),
            pushButtomText: "اضافة نوع جديد",
          ),
        ],
      ),
    );
  }
}
