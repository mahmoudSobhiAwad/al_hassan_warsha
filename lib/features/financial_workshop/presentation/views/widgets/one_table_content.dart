import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class ContentOfFinancialTable extends StatelessWidget {
  const ContentOfFinancialTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGray1, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                    child: CustomTextWithTheSameStyle(
                  text: "مطبخ امريكي-فرز اول",
                )),
                const Expanded(child: SizedBox()),
                const Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "الحاج محمد ابو محمد",
                    )),
                const Expanded(child: SizedBox()),
                const Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "دفع بالتقسيط",
                    )),
                const Expanded(child: SizedBox()),
                const Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "10000 جنية",
                    )),
                const Expanded(child: SizedBox()),
                const Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "30000 جنية",
                    )),
                const Expanded(child: SizedBox()),
                const Expanded(
                    flex: 1,
                    child: Center(
                      child: CustomTextWithTheSameStyle(
                        text: "3",
                      ),
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomTextFormField(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      fillColor: AppColors.white,
                      enableFill: true,
                      borderRadius: 8,
                      borderWidth: 2,
                      borderColor: AppColors.lightGray1,
                      suffixText: "جنية",
                      labelWidget: Text(
                        "...................",
                        style: AppFontStyles.extraBold12(context)
                            .copyWith(color: AppColors.lightGray2),
                      ),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "تنزيل دفعة",
            style: AppFontStyles.extraBold16(context)
                .copyWith(color: AppColors.white),
          ),
        )
      ],
    );
  }
}
