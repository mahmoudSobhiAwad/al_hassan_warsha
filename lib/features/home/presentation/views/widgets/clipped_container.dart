import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                colors: [
                  AppColors.darkBlue, // Starting color
                  AppColors.blue, // Starting color
                   // Ending color
                ],
                begin: Alignment.topLeft, // Gradient starts from the top left
                end: Alignment.bottomRight, // Gradient ends at the bottom right
                            ),
                  ),
                  height: MediaQuery.sizeOf(context).height*0.33,
                  width: double.infinity,
                ),
              ),
            );
  }
}