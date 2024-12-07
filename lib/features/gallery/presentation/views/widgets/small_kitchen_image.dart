import 'dart:io';

import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/safe_search_extentsion.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:flutter/material.dart';

class SmallKitchenTypeImage extends StatelessWidget {
  const SmallKitchenTypeImage(
      {super.key,
      required this.model,
      this.imageWidth,
      this.enableInner = true,
      this.enableClose = false});

  final bool enableInner;
  final bool enableClose;
  final KitchenModel model;
  final double? imageWidth;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Stack(
        alignment: enableClose ? Alignment.topLeft : Alignment.bottomCenter,
        children: [
          CustomSmallImageWithCustomWidth(
            widthOfImage: imageWidth,
              pickedMedia: model.getPickedMedia().tryIndex(0)),
          enableInner
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    width: context.screenWidth *(imageWidth?? 0.2),
                    decoration: const BoxDecoration(
                        color: AppColors.blackOpacity50,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Text(
                          model.kitchenName ?? "",
                          style: AppFontStyles.extraBoldNew20(context)
                              .copyWith(color: AppColors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          model.kitchenDesc ?? "",
                          style: AppFontStyles.extraBoldNew18(context)
                              .copyWith(color: AppColors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          enableClose
              ? Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.close,
                            color: AppColors.red,
                            size: 33,
                          ))))
              : const SizedBox()
        ],
      ),
    );
  }
}

class CustomSmallImageWithCustomWidth extends StatelessWidget {
  const CustomSmallImageWithCustomWidth(
      {super.key, this.widthOfImage, required this.pickedMedia});

  final double? widthOfImage;
  final PickedMedia? pickedMedia;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: 
        
        pickedMedia==null?Image.asset(
              scale: 1,
              HomeAssets.emptySceen,
              width: context.screenWidth * 0.2,
              height:context.screenHeight * 0.2,
              fit: BoxFit.fill,
            ):
        
        switch (pickedMedia!.mediaType) {
          MediaType.image => Image.file(
              File(pickedMedia!.mediaPath,),
              errorBuilder: (context,_,s){
                return const Icon(Icons.error,color: AppColors.red,);
              },
              width: context.screenWidth * (widthOfImage ?? 0.2),
              height: context.screenHeight * 0.2,
              fit: BoxFit.fill,
            ),
          MediaType.video => const CustomVideoItem(),
          MediaType.unknown => Image.asset(
              scale: 1,
              HomeAssets.emptySceen,
              width: context.screenHeight* 0.2,
              height: context.screenHeight * 0.2,
              fit: BoxFit.fitWidth,
            ),
        });
  }
}
