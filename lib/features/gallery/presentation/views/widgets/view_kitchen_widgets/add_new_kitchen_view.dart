import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/custom_kitchen_gallery_parent.dart';
import 'package:flutter/material.dart';

class ViewKitchenInGalleryView extends StatelessWidget {
  const ViewKitchenInGalleryView({super.key,required this.pagesGalleryEnum});
  final PagesGalleryEnum pagesGalleryEnum;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: CustomAdaptiveLayout(
            desktopLayout: (context) => KitchenGalleryCustomView(pagesGalleryEnum: pagesGalleryEnum,),
            mobileLayout: (context) => const Text("Mobile Layout"),
            tabletLayout: (context) => const Text("Tablet Layout"),
          ),
        ),
      ),
    );
  }
}

