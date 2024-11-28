
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_big_image_with_inner_shadow.dart';
import 'package:flutter/material.dart';

class AutoScrollingPageView extends StatelessWidget {
  const AutoScrollingPageView({super.key,required this.kitchenModelList,required this.pageController});
  final List<KitchenModel>kitchenModelList;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
      return  AspectRatio(
            aspectRatio: 1225/250,
            child: PageView.builder(
              
              controller: pageController,
              itemCount: kitchenModelList.length,
              itemBuilder: (context,index){
              return CustomImageWithInnerShadow(model: kitchenModelList[index],);
            }),
          );
  }
  }
  

