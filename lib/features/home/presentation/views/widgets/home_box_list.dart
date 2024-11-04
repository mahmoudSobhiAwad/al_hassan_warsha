import 'package:al_hassan_warsha/features/home/data/home_data.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_item.dart';
import 'package:flutter/material.dart';

class HomeItemsList extends StatelessWidget {
  const HomeItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HomeItem(homeModel: homeModelList[0]),
        const SizedBox(width: 35,),
        HomeItem(homeModel: homeModelList[1]),
        const SizedBox(width: 35,),
        HomeItem(homeModel: homeModelList[2]),
      ],
      
    );
  }
}