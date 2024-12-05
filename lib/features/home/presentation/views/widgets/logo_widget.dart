
import 'package:al_hassan_warsha/core/utils/app_images/home_images.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_ingradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
               padding: const EdgeInsets.all(24.0),
               child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  constraints:const BoxConstraints(
                    maxHeight: 80,
                    maxWidth: 100
                  ),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: customLinearGradient()
                  ),
                  child: SvgPicture.asset(HomeAssets.logo,fit: BoxFit.contain,)
                ),
                           ),
             );
  }
}
