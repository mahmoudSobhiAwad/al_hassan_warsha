import 'package:al_hassan_warsha/core/utils/functions/extentions.dart';
import 'package:flutter/material.dart';

class CustomAdaptiveLayout extends StatelessWidget {
  const CustomAdaptiveLayout({
    super.key,
    required this.desktopLayout,
    required this.mobileLayout,
    required this.tabletLayout,
  });

  final Widget Function(
    BuildContext context,
  ) mobileLayout;
  final Widget Function(
    BuildContext context,
  ) tabletLayout;
  final Widget Function(
    BuildContext context,
  ) desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileLayout(
            context,
          );
        } else if (constraints.maxWidth < 1025) {
          return tabletLayout(context);
        } else {
          return desktopLayout(context);
        }
      },
    );
  }
}

class AppFontsLayout {
  static bool isMobile(BuildContext context) => context.screenWidth < 600;

  static bool isTablet(BuildContext context) => context.screenWidth < 1025;

  static bool isDesktop(BuildContext context) => context.screenWidth >= 1025;
}
