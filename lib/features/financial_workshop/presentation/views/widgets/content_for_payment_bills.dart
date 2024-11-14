import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class ContentForBillsPayment extends StatelessWidget {
  const ContentForBillsPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 11,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomTextWithTheSameStyle(
                          textStyle: AppFontStyles.extraBold16(context),
                          text: "محمد احمد علي",
                        )),
                    const Expanded(child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: CustomTextWithTheSameStyle(
                          textStyle: AppFontStyles.extraBold18(context),
                          text: "4000",
                        )),
                    const Expanded(child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: CustomTextWithTheSameStyle(
                          textStyle: AppFontStyles.extraBold18(context),
                          text: " 1 نوفمبر 2024",
                        )),
                    const Expanded(child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: CustomTextWithTheSameStyle(
                          textStyle: AppFontStyles.extraBold18(context),
                          text: "يومي",
                        )),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            "تحديد",
                            style: AppFontStyles.extraBold18(context),
                          )),
                          const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.check_box_outline_blank_rounded))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            Expanded(child: SizedBox()),
            Expanded(
                flex: 11,
                child: Divider(
                  thickness: 2,
                )),
            Expanded(child: SizedBox()),
          ],
        )
      ],
    );
  }
}
