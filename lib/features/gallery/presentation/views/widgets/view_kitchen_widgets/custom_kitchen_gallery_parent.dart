import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/add_kitchen_widgets/add_kitchen_view.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/view_kitchen_details.dart';
import 'package:flutter/material.dart';

class KitchenGalleryCustomView extends StatelessWidget {
  const KitchenGalleryCustomView({super.key,required this.pagesGalleryEnum});
  final PagesGalleryEnum pagesGalleryEnum;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(currIndex: 0, changeIndex: (pageIndex) {}),
        const SizedBox(
          height: 24,
        ),
         Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWithLinking(),
                const SizedBox(
                  height: 12,
                ),
                switch(pagesGalleryEnum){
                  PagesGalleryEnum.view => const ViewKitchenDetailsBody(),
                  PagesGalleryEnum.edit => const SizedBox(),
                  PagesGalleryEnum.add => const AddKitchenView(),
                },
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}