import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:flutter/material.dart';

class SmallKitchenTypeImage extends StatelessWidget {
  const SmallKitchenTypeImage({super.key,required this.widthOfImage,required this.model,this.enableInner=true,this.enableClose=false});
  final double widthOfImage;
  final bool enableInner;
  final bool enableClose;
  final KitchenModel model;
  
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        alignment: enableClose? Alignment.topLeft:Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://nolte-prod-ebcwh6b9axcgebb3.z01.azurefd.net/-/jssmedia/project/nolte-jss/corporate-website/produkt-moods/metal/nolte_kuechen_metal_stahl_grau_lux_weiss_2/3to2.jpg?mw=1440&as=0",
              width: MediaQuery.sizeOf(context).width * widthOfImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          enableInner? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: MediaQuery.sizeOf(context).width * widthOfImage,
              decoration: const BoxDecoration(
                  color: AppColors.blackOpacity50,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Text(
                    model.kitchenName??"",
                    style: AppFontStyles.extraBold35(context)
                        .copyWith(color: AppColors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.kitchenDesc??"",
                    style: AppFontStyles.extraBold24(context)
                        .copyWith(color: AppColors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ):const SizedBox(),
          enableClose? Padding(
            padding: const EdgeInsets.all(3),
           // alignment: Alignment.topLeft,
            child: Container(
             
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: const IconButton(onPressed: null, icon: Icon(Icons.close,color: AppColors.red,size: 33,)))):const SizedBox()
        ],
      ),
    );
  }
}
