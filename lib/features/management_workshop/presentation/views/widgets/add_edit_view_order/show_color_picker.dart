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
          backgroundColor: AppColors.white.withOpacity(0.8),
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
            child: BlockPicker(
                availableColors: _defaultColors,
                pickerColor: pickedColor,
                onColorChanged: (color) {
                  pickedColor = color;
                }),
          ),
        );
      });
}

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
  Colors.white,
];
