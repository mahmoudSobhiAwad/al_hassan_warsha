import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_check_box_with_title.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_drop_down.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تحويل مالي",
            style: AppFontStyles.extraBold35(context),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: CustomColumnWithTextInAddNewType(
                    textStyle: AppFontStyles.extraBold18(context),
                    enableBorder: true,
                    text: "المعاملة",
                    borderWidth: 2,
                    textLabel: "غرض التحويل",
                    maxLine: 1,
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                    textStyle: AppFontStyles.extraBold18(context),
                    enableBorder: true,
                    text: "قيمة المبلغ",
                    textLabel: ".......................",
                    maxLine: 1,
                    borderWidth: 2,
                    suffixText: "جنية",
                  )),
              const Expanded(child: SizedBox()),
              const Expanded(
                  flex: 2,
                  child: CustomContainerWithDropDownList(
                    headerText: "دفع/استلام",
                    primaryText: "استلام",
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: CustomColumnWithTextInAddNewType(
                    enableBorder: true,
                    borderWidth: 2,
                    textStyle: AppFontStyles.extraBold18(context),
                    text: "تاريخ المعاملة",
                    textLabel: "",
                    maxLine: 1,
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                  )),
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "طريقة الدفع",
                        style: AppFontStyles.extraBold18(context),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const CustomTextWithCheckBox(
                        title: "كاش",
                      ),
                      const CustomTextWithCheckBox(
                        title: "تحويل بنكي",
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
