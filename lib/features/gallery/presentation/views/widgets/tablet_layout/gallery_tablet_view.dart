import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryTabletView extends StatelessWidget {
  const GalleryTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconButton(
                onPressed: null, icon: Icon(FontAwesomeIcons.bars)),
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
              iconBehind: Icons.create,
              padding: EdgeInsets.all(8),
              pushButtomText: "اضافة نوع جديد",
            ),
          ],
        )
      ],
    );
  }
}
