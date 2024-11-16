import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_container_with_above_text.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/media_view_in_gallery.dart';
import 'package:flutter/material.dart';

class ViewKitchenDetailsBody extends StatelessWidget {
  const ViewKitchenDetailsBody({super.key, required this.changeEditState});
  final void Function(bool enableEdit) changeEditState;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "مطبخ رقم 1",
              style: AppFontStyles.extraBold40(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomPushContainerButton(
                  onTap: () {
                    changeEditState(true);
                  },
                  iconBehind: Icons.create_rounded,
                  borderRadius: 16,
                  pushButtomText: "تعديل",
                ),
                const SizedBox(width: 24,),
                const CustomPushContainerButton(
                  borderRadius: 16,
                  iconBehind: Icons.delete,
                  color: AppColors.red,
                  pushButtomText: "حذف",
                ),
              ],
            ),
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
    );
  }
}
