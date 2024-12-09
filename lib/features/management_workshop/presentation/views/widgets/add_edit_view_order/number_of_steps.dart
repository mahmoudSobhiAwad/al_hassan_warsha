import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberOfStepsInBillDetails extends StatelessWidget {
  const NumberOfStepsInBillDetails({
    super.key,
    required this.pillModel,
    required this.changeStepsCounter,
  });

  final PillModel pillModel;
  final void Function(bool p1)? changeStepsCounter;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      textInnerStyle: AppFontStyles.extraBoldNew18(context),
      onChanged: (value) {
        if (value == null || value.isEmpty) {
        } else {
          pillModel.stepsCounter =
              BigInt.parse(convertToEnglishNumbers(value)).toInt();
        }
      },
      text: "عدد الدفعات",
      textAlign: TextAlign.center,
      readOnly: changeStepsCounter == null ? true : false,
      textLabel: "",
      controller: TextEditingController(
          text: convertToArabicNumbers(pillModel.stepsCounter.toString())),
      textInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[\u0660-\u0669\u06F0-\u06F9]'), // Arabic numerals only
        ),
      ],
      textStyle: AppFontStyles.extraBoldNew16(context),
      enableBorder: true,
      suffixIcon: changeStepsCounter != null
          ? IconButton(
              onPressed: () {
                changeStepsCounter!(true);
              },
              icon: const Icon(
                Icons.add_circle_outlined,
                size: 30,
              ))
          : const SizedBox(),
      prefixIcon: changeStepsCounter != null
          ? IconButton(
              onPressed: () {
                changeStepsCounter!(false);
              },
              icon: const Icon(
                CupertinoIcons.minus_circle_fill,
                color: Colors.black,
                size: 30,
              ))
          : const SizedBox(),
    );
  }
}
