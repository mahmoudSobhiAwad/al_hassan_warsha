import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_app_bar.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_container_with_above_text.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/app_bar_with_linking.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/media_view_in_gallery.dart';
import 'package:flutter/material.dart';

class AddNewKitchenViewDesktopLayOut extends StatelessWidget {
  const AddNewKitchenViewDesktopLayOut({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "مطبخ رقم 1",
                      style: AppFontStyles.extraBold40(context),
                    ),
                    const CustomPushContainerButton(
                      iconBehind: Icons.create_rounded,
                      pushButtomText: "تعديل",
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const CustomContainerWithTextAbove(
                  textAbove: "الوصف",
                  describtionInCont:
                      "مطبخ يتميز بأسلوب حديث تم تصميمه سنة 2024 علي يد خبراء مطبخ يتميز بأسلوب حديث تم تصميمه سنة 2024 علي يد خبراء مطبخ يتميز بأسلوب حديث تم هراء ",
                ),
                const SizedBox(
                  height: 12,
                ),
                const CustomPushContainerButton(
                  enableIcon: false,
                  pushButtomText: "الوسائط",
                  padding: EdgeInsets.all(20),
                ),
                const SizedBox(
                  height: 12,
                ),
                const MediaInViewGallryItem(),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "سعر المتر",
                      style: AppFontStyles.extraBold40(context),
                    ),
                    const CustomPushContainerButton(
                      pushButtomText: "٢٠٠٠ جنية",
                      enableIcon: false,
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Center(
                    child: CustomPushContainerButton(
                  borderRadius: 15,
                  pushButtomText: "اختيار المطبخ",
                  color: AppColors.vibrantGreen,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                )),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

