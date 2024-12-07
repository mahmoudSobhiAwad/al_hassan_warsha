import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/filter_orders.dart';
import 'package:flutter/material.dart';

class HeaderForBillsPayment extends StatelessWidget {
  const HeaderForBillsPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 11,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: const BoxDecoration(
                color: AppColors.veryLightGray,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 2,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBoldNew16(context),
                      text: "اسم الموظف",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBoldNew16(context),
                      text: "المرتب",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBoldNew16(context),
                      text: "تاريخ القبض",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      textStyle: AppFontStyles.extraBoldNew16(context),
                      text: " نظام القبض",
                    )),
                const Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomContainerToPickHistory(
                      fillColor: AppColors.veryLightGray,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            "تحديد الكل ",
                            style: AppFontStyles.extraBoldNew16(context),
                          )),
                          const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.check_box_outline_blank_rounded))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

