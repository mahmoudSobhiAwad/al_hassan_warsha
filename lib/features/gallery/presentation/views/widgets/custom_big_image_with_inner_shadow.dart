import 'dart:io';

import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/custom_video_item.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_inner_shadow.dart';
import 'package:flutter/material.dart';

class CustomImageWithInnerShadow extends StatelessWidget {
  const CustomImageWithInnerShadow({
    super.key,
    this.aspectRatio,
    this.aspectRatioInner,
    this.fitType,
    this.enableShadow=true,
    this.imageWidth,
    required this.model
  });
  final double? aspectRatio;
  final double? aspectRatioInner;
  final BoxFit?fitType;
  final double?imageWidth;
  final bool enableShadow;
  final KitchenModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
       model.kitchenMediaList.isNotEmpty? AspectRatio(
          aspectRatio:aspectRatio?? 1225/250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child:model.kitchenMediaList.first.mediaType==MediaType.image? Image.file(File(model.kitchenMediaList.first.path),fit:fitType?? BoxFit.fill,width: imageWidth,):const CustomVideoItem(),
            ),
           ):AspectRatio(
          aspectRatio:aspectRatio?? 1225/250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child:Image.asset(HomeAssets.emptySceen)
            ),
           ),
         enableShadow? CustomInnerShadowInLastKitchen(aspectRatio: aspectRatioInner,desc:model.kitchenDesc??"" ,name: model.kitchenName??"",):const SizedBox(),
      ],
    ),
    );
  }
}
