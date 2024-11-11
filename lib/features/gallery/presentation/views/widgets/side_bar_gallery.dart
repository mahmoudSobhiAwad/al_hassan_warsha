import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/header_section.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/list_kitchen_types.dart';
import 'package:flutter/material.dart';

class SideBarGallery extends StatelessWidget {
  const SideBarGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.veryLightGray,
      child: const CustomScrollView(
        slivers: [
          HeaderSetionInGallery(),
          ListOfKitchenTypes(),
        ],
      ),
    );
  }
}