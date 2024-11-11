import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class OneOrderItem extends StatelessWidget {
  const OneOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: AppColors.lightGray2
        )
      ),
      child: const Row(
        children: [
          Expanded(
              child: CustomTextWithTheSameStyle(
            text: "مطبخ امريكي-فرز اول",
          )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 2,
              child: CustomTextWithTheSameStyle(
                text:
                    "مطبخ امريكي-فرز اول- استيراد خارجي خالص من اي عيوب وضد الكسر و ....",
              )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: "14/10/2024",
              )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: "محمد علي السيد",
              )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: "011145469898",
              )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: " تل البلد-الحمادة ",
              )),
          Expanded(child: SizedBox()),
          Expanded(
              flex: 1,
              child: CustomTextWithTheSameStyle(
                text: " 15000 جنية",
              )),
        ],
      ),
    );
  }
}

