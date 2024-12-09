import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/show_color_in_big_pic.dart';
import 'package:al_hassan_warsha/features/management_workshop/presentation/views/widgets/add_edit_view_order/show_color_picker.dart';
import 'package:flutter/material.dart';

class GetColorForOrder extends StatelessWidget {
  const GetColorForOrder({
    super.key,
    required this.colorOrderModel,
    required this.changeColorValue,
    this.label,
    this.textStyle,
  });

  final ColorOrderModel colorOrderModel;
  final void Function(int p1)? changeColorValue;
  final String?label;
  final TextStyle?textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "اللون المطلوب",
      onChanged: (value) {
        colorOrderModel.colorName = value ?? "";
      },
      controller: TextEditingController(text: colorOrderModel.colorName??""),
      readOnly:changeColorValue==null?true:false ,
      enableBorder: true,
      textStyle:textStyle?? AppFontStyles.extraBoldNew16(context),
      textLabel:label?? "حدد اسم اللون او اختار الدرجة المناسبة",
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          colorOrderModel.colorDegree != null
              ? IconButton(
                  onPressed: () {
                    showColorInBigMood(
                        context,
                        Color(
                          colorOrderModel.colorDegree!,
                        ));
                  },
                  icon: Icon(
                    Icons.square,
                    color: Color(colorOrderModel.colorDegree!),
                  ))
              : const SizedBox(),
          changeColorValue != null
              ? IconButton(
                  onPressed: () {
                    showColorPicker(context, onColorChanged: (color) {
                      changeColorValue!(color.value);
                    });
                  },
                  icon: const Icon(Icons.color_lens_rounded))
              : const SizedBox(),
        ],
      ),
    );
  }
}
