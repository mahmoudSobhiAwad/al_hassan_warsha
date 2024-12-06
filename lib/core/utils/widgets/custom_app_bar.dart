import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar_item.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/features/home/data/home_bar_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.changeIndex,
      required this.currIndex,
      this.textStyle,
      this.enableLogo = true});
  final void Function(int index) changeIndex;
  final int currIndex;
  final bool enableLogo;
  final TextStyle?textStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: customLinearGradient(),
      ),
      child: Row(
        children: [
          if (enableLogo) SvgPicture.asset(HomeAssets.homeLogo),
          const Spacer(),
          ...List.generate(
              homeBarData.length,
              (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: index == 1 ? context.screenWidth* 0.05 : 0.0),
                    child: InkWell(
                        onTap: () {
                          changeIndex(index);
                        },
                        child: AppBarItem(
                          textStyle: textStyle,
                          text: homeBarData[index],
                          enable: index == currIndex,
                        )),
                  )),
          const Spacer(),
        ],
      ),
    );
  }
}
