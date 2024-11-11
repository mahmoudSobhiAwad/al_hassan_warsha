import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_text_form_field.dart';
import 'package:al_hassan_warsha/core/utils/widgets/rotate_extension.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class SearchBarInManagment extends StatelessWidget {
  const SearchBarInManagment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                customLowBoxShadow(),
              ]),
              child: CustomTextFormField(
                enableFill: true,
                enableFocusBorder: false,
                fillColor: Colors.white,
                borderRadius: 12,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                labelWidget: Text(
                  "ادخل بعض البيانات للبحث عن ........",
                  style: AppFontStyles.extraBold18(context)
                      .copyWith(color: AppColors.lightGray2),
                ),
                suffixWidget: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.search,
                      color: AppColors.lightGray2,
                      size: 30,
                    )),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [customLowBoxShadow()],
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "البحث ب",
                  style: AppFontStyles.extraBold20(context),
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.arrow_back_ios).rotate(angle: 90))
              ],
            ),
          ),
          const Expanded( child: SizedBox()),
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications,
                size: 40,
              )),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}


