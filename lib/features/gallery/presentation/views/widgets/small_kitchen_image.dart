import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';

class SmallKitchenTypeImage extends StatelessWidget {
  const SmallKitchenTypeImage({super.key,required this.widthOfImage,this.enableInner=true});
  final double widthOfImage;
  final bool enableInner;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://nolte-prod-ebcwh6b9axcgebb3.z01.azurefd.net/-/jssmedia/project/nolte-jss/corporate-website/produkt-moods/metal/nolte_kuechen_metal_stahl_grau_lux_weiss_2/3to2.jpg?mw=1440&as=0",
              width: MediaQuery.sizeOf(context).width * widthOfImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          enableInner? Container(
            height: 60,
            width: MediaQuery.sizeOf(context).width * widthOfImage,
            decoration: const BoxDecoration(
                color: AppColors.blackOpacity50,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: [
                  Text(
                    "مطبخ رقم 1 ",
                    style: AppFontStyles.extraBold18(context)
                        .copyWith(color: AppColors.white),
                  ),
                  Text(
                    "15 قطعة مساحة 7 متر",
                    style: AppFontStyles.extraBold18(context)
                        .copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ):const SizedBox(),
        ],
      ),
    );
  }
}
