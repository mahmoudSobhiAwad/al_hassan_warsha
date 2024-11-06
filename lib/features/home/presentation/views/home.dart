import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_adaptive_layout.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_desktop_layout.dart';
import 'package:flutter/material.dart';
class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.veryLightGray2,
        body:CustomAdaptiveLayout(
          desktopLayout: (context)=> const  HomeScreenDesktopLayOut(),
          mobileLayout: (context)=>const Text("Mobile Layout"),
          tabletLayout: (context)=>const Text("Tablet Layout"),)
      ),
    );
  }
}

