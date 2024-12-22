import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/core/utils/widgets/custom_push_button.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateTableFieldsWithButton extends StatelessWidget {
  const CreateTableFieldsWithButton({
    super.key,
    required this.rowsController,
    required this.columnsController,
    required this.enableCounter,
    required this.enableOrDisableCounter,
    required this.createTable,
  });

  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final bool enableCounter;
  final void Function() enableOrDisableCounter;
  final void Function() createTable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(child: SizedBox(width: 16)),
        Expanded(
          flex: 3,
          child: CustomColumnWithTextInAddNewType(
            enableBorder: true,
            controller: rowsController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
              )
            ],
            text: 'عدد الصفوف',
            borderWidth: 2,
            textStyle: AppFontStyles.extraBoldNew16(context),
            textLabel: '',
          ),
        ),
        const Expanded(child: SizedBox(width: 16)),
        Expanded(
          flex: 3,
          child: CustomColumnWithTextInAddNewType(
            enableBorder: true,
            controller: columnsController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]'),
              )
            ],
            text: 'عدد الاعمدة',
            borderWidth: 2,
            textStyle: AppFontStyles.extraBoldNew16(context),
            textLabel: '',
          ),
        ),
        const Expanded(child: SizedBox(width: 16)),
        Row(
          children: [
            Text(
              "اضافة ترقيم تلقائي",
              style: AppFontStyles.extraBoldNew16(context),
            ),
            Checkbox(
                value: enableCounter,
                activeColor: AppColors.green,
                onChanged: (value) {
                  enableOrDisableCounter();
                }),
          ],
        ),
        const Expanded(child: SizedBox(width: 16)),
        CustomPushContainerButton(
          onTap: createTable,
          pushButtomText: "إنشاء جدول",
          pushButtomTextFontSize: 16,
          borderRadius: 12,
          iconBehind: Icons.create,
          iconSize: 30,
          padding: const EdgeInsets.all(10),
        ),
        const Expanded(child: SizedBox(width: 16)),
      ],
    );
  }
}
