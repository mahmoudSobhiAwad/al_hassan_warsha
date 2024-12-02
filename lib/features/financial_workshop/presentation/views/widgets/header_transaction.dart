import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class HeaderForTransactionHistory extends StatelessWidget {
  const HeaderForTransactionHistory({super.key, this.enableLastWidget = true});
  final bool enableLastWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 14,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      flex: 4,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "قيمة المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "تاريخ المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "طريقة المعاملة",
                      )),
                  const Expanded(child: SizedBox()),
                  Expanded(
                      flex: 2,
                      child: CustomTextWithTheSameStyle(
                        textStyle: AppFontStyles.extraBold18(context),
                        text: "دفع/ استلام",
                      )),
                ],
              ),
            ),
            enableLastWidget
                ? const Expanded(flex: 3, child: SizedBox())
                : const SizedBox(),
          ],
        ),
         Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              flex: 14,
              child: Divider(
                thickness: 2,
              ),
            ),
            enableLastWidget
                ? const Expanded(flex: 3, child: SizedBox())
                : const Expanded(child: SizedBox()),
          ],
        )
      ],
    );
  }
}
