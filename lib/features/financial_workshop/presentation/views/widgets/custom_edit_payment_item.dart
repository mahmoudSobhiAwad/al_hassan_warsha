import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class CustomEditPillItem extends StatelessWidget {
  const CustomEditPillItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 4,
            child: CustomColumnWithTextInAddNewType(
              borderWidth: 2,
              text: "اسم الموظف ",
              textLabel: "",
              enableBorder: true,
              textStyle: AppFontStyles.extraBold18(context),
            )),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 3,
            child: CustomColumnWithTextInAddNewType(
              borderWidth: 2,
              text: "المرتب",
              textLabel: "",
              enableBorder: true,
              textStyle: AppFontStyles.extraBold18(context),
              suffixText: "جنية",
            )),
        const Expanded(child: SizedBox()),
        const Expanded(
            flex: 2,
            child: CustomContainerWithDropDownList(
              primaryText: "أسبوعي",
              headerText: "نظام القبض",
            )),
        const Expanded(child: SizedBox()),
        Expanded(
            flex: 2,
            child: CustomColumnWithTextInAddNewType(
              borderWidth: 2,
              text: "يوم  القبض",
              textLabel: "",
              suffixIcon: const Icon(Icons.calendar_month_rounded),
              enableBorder: true,
              textStyle: AppFontStyles.extraBold18(context),
            )),
        const Expanded(child: SizedBox()),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete,
            color: AppColors.red,
            size: 40,
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}