import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/complete_kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/latest_added_kitchen_list.dart';
import 'package:flutter/material.dart';

class GalleryBody extends StatelessWidget {
  const GalleryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المضاف حديثا",
            style: AppFontStyles.extraBold50(context),
          ),
          const SizedBox(
            height: 8,
          ),
          const AutoScrollingPageView(),
          const SizedBox(
            height: 24,
          ),
          Text(
            "انواع المطابخ",
            style: AppFontStyles.extraBold40(context),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              ...List.generate(4, (index) {
                return Padding(
                  padding:const EdgeInsets.only(bottom: 20.0),
                  child: CompleteKitchenType(isEmpty: index==1,),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
