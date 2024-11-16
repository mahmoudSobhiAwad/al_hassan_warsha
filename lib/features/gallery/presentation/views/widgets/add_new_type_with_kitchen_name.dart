import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/kitchen_item_type.dart';
import 'package:flutter/material.dart';

class AddnewTypeWithKitchenName extends StatelessWidget {
  const AddnewTypeWithKitchenName({super.key,required this.model});
final KitchenTypeModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        KitchenTypeItem(
          model:model ,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        const Expanded(
          flex: 12,
          child: SizedBox(),
        ),
        TextButton(
            onPressed: null,
            child: Text(
              "إضافة جديد",
              style: AppFontStyles.extraBold30(context)
                  .copyWith(color: AppColors.blue),
            )),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
