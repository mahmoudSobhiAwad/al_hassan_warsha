import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:flutter/material.dart';

class AddsForOrder extends StatelessWidget {
  const AddsForOrder(
      {super.key,
      required this.list,
      this.addMore,
      required this.removeItem,
      this.addWidth,
      this.isReadOnly = false});
  final List<ExtraInOrderModel> list;
  final void Function()? addMore;
  final void Function(int) removeItem;
  final double? addWidth;
  final bool isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addMore == null && list.isEmpty
            ? Text(
                "لا يوجد اي اضافات ",
                style: AppFontStyles.bold18(context),
                textAlign: TextAlign.center,
              )
            : Text(
                "اضافات للمنتج",
                style: AppFontStyles.extraBoldNew16(context),
              ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: [
            ...List.generate(list.length, (index) {
              return SizedBox(
                width: addWidth ?? 300,
                child: CustomTextFormField(
                  readOnly: isReadOnly,
                  initialValue: list[index].extraName,
                  onChanged: (value) {
                    list[index].extraName = value;
                  },
                  borderRadius: 12,
                  suffixWidget: !isReadOnly
                      ? IconButton(
                          onPressed: () {
                            removeItem(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                          ))
                      : null,
                  borderColor: AppColors.lightGray2,
                  borderWidth: 1,
                  fillColor: AppColors.white,
                  maxLine: 1,
                  enableBorder: true,
                ),
              );
            }),
            isReadOnly
                ? const SizedBox()
                : InkWell(
                    onTap: addMore,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.lightGray1,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "المزيد",
                            style: AppFontStyles.extraBoldNew16(context),
                          ),
                          const Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
