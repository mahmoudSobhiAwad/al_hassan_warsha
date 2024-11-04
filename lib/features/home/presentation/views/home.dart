import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/clipped_container.dart';
import 'package:al_hassan_warsha/features/home/presentation/views/widgets/home_box_list.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.veryLightGray2,
        body: Stack(
          children: [
            const ClippedContainer(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("آل حسن ",style: AppFontStyles.extraBold90(context),),
                  const SizedBox(height: 24,),
                  Text("اختيارك الأمثل لجميع أعمال الالوميتال",style: AppFontStyles.extraBold60(context),),
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: HomeItemsList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

