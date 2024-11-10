import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar_item.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:al_hassan_warsha/features/home/data/home_bar_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,required this.changeIndex,required this.currIndex});
  final void Function(int index) changeIndex;
  final int currIndex;
  @override
  Widget build(BuildContext context) {
    double spacing=MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        gradient: customLinearGradient(),
      ),
      child: Row(
        children: [
          SvgPicture.asset(HomeAssets.homeLogo),
          const Spacer(),
          ...List.generate(homeBarData.length,(index)=>Padding(
            padding: EdgeInsets.symmetric(horizontal: index==1?spacing*0.05:0.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: (){
                  changeIndex(index);
                },
                child: AppBarItem(text: homeBarData[index],enable: index==currIndex,)),
            ),
          )),
           const Spacer(),
        ],
      ),
    );
  }
}