import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_container_with_above_text.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/view_kitchen_widgets/media_view_in_gallery.dart';
import 'package:flutter/material.dart';

class ViewKitchenDetailsBody extends StatelessWidget {
  const ViewKitchenDetailsBody({super.key, required this.changeEditState,required this.kitchenModel});
  final void Function(bool enableEdit) changeEditState;
  final KitchenModel? kitchenModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                kitchenModel?.kitchenName??"",
                style: AppFontStyles.extraBold40(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Expanded(flex: 2,child: SizedBox()),
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
        CustomContainerWithTextAbove(
          textAbove: "الوصف",
          describtionInCont:
              kitchenModel?.kitchenDesc??"",
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
