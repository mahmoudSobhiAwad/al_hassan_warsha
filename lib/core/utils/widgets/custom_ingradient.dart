  import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/painting.dart';

LinearGradient customLinearGradient() {
    return const LinearGradient(
                    colors: [
                  AppColors.darkBlue, // Starting color
                  AppColors.blue, // Starting color
                    // Ending color
                     ],
              begin: Alignment.topLeft, // Gradient starts from the top left
              end: Alignment.bottomRight, // Gradient ends at the bottom right
              );
  }