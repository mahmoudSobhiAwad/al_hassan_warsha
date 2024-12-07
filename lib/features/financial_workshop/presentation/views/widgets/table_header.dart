import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_text_style_in_header.dart';
import 'package:flutter/material.dart';

class TableHeaderInFinancial extends StatelessWidget {
  const TableHeaderInFinancial({
    super.key,
    required this.onFarz,
  });
  final void Function(SearchModel) onFarz;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.veryLightGray2,
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: CustomTextWithTheSameStyle(
                  text: "الطلب",
                )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "اسم العميل",
                    )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "نظام الدفع",
                    )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "المقدم",
                    )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "المبلغ المتبقي",
                    )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 1,
                    child: CustomTextWithTheSameStyle(
                      text: "الدفعات المتبقية",
                    )),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CustomTextWithTheSameStyle(
                      text: "المبلغ المستحق",
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.veryLightGray2, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  "فرز",
                  style: AppFontStyles.extraBoldNew16(context),
                ),
                PopupMenuButton<SearchModel>(
                    color: AppColors.veryLightGray,
                    itemBuilder: (context) {
                      return [
                        ...List.generate(3, (index) {
                          return PopupMenuItem(
                            value: farzList[index],
                            child: Text(
                              farzList[index].valueArSearh,
                              style: AppFontStyles.extraBoldNew16(context),
                            ),
                          );
                        })
                      ];
                    },
                    onSelected: (value) {
                      onFarz(value);
                    },
                    child: const Icon(Icons.filter_list_rounded))
              ],
            ),
          ),
        )
      ],
    );
  }
}

List<SearchModel> farzList = [
  SearchModel(valueArSearh: "الكل", valueEnSearh: "-1"),
  SearchModel(valueArSearh: "عند الاستلام", valueEnSearh: "0"),
  SearchModel(valueArSearh: "نظام التقسيط", valueEnSearh: "1"),
];
