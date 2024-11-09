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
  });
  final double? aspectRatio;
  final double? aspectRatioInner;
  final BoxFit?fitType;
  final double?imageWidth;
  final bool enableShadow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio:aspectRatio?? 1225/250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network("https://nolte-prod-ebcwh6b9axcgebb3.z01.azurefd.net/-/jssmedia/project/nolte-jss/corporate-website/produkt-moods/metal/nolte_kuechen_metal_stahl_grau_lux_weiss_2/3to2.jpg?mw=1440&as=0",fit:fitType?? BoxFit.fill,width: imageWidth,),
            ),
           ),
         enableShadow? CustomInnerShadowInLastKitchen(aspectRatio: aspectRatioInner,):const SizedBox(),
      ],
    ),
    );
  }
}
