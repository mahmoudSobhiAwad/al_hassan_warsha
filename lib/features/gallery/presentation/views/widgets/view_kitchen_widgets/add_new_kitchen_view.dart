import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/desktop_ui.dart';
import 'package:flutter/material.dart';

class ViewKitchenInGalleryView extends StatelessWidget {
  const ViewKitchenInGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: CustomAdaptiveLayout(
            desktopLayout: (context) => const AddNewKitchenViewDesktopLayOut(),
            mobileLayout: (context) => const Text("Mobile Layout"),
            tabletLayout: (context) => const Text("Tablet Layout"),
          ),
        ),
      ),
    );
  }
}

