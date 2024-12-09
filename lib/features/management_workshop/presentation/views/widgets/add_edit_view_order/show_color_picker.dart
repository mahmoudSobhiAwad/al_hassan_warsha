
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<dynamic> showColorPicker(BuildContext context,
    {required void Function(Color) onColorChanged}) {
  Color pickedColor = Colors.black;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(AppColors.blueGray),
                ),
                onPressed: () {
                  onColorChanged(pickedColor);
                  Navigator.pop(context);
                },
                child: Text(
                  "حفظ",
                  style: AppFontStyles.extraBoldNew16(context)
                      .copyWith(color: Colors.white),
                ))
          ],
          title: Text(
            "اختار درجة لون مناسبة",
            style: AppFontStyles.bold18(context),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
                pickerColor: pickedColor,
                onColorChanged: (color) {
                  pickedColor = color;
                }),
          ),
        );
      });
}