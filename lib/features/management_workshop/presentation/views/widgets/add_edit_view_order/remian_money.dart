import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemainMoneyInBillDetails extends StatelessWidget {
  const RemainMoneyInBillDetails({
    super.key,
    required this.pillModel,
    this.fontSizeInner,
  });

  final PillModel pillModel;
  final double?fontSizeInner;
  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "المتبقي ",
      textLabel: "",
      readOnly: true,
      controller: TextEditingController(
        text: convertToArabicNumbers(pillModel.remian),
      ),
      textInnerStyle:
          AppFontStyles.extraBoldNew20(context).copyWith(letterSpacing: 3,fontSize: fontSizeInner),
      textStyle: AppFontStyles.extraBoldNew16(context),
      enableBorder: true,
      suffixIcon: Text(
        "جنية",
        style: AppFontStyles.extraBoldNew16(context),
      ),
    );
  }
}
