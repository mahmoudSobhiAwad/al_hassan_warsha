import 'package:al_hassan_warsha/core/utils/style/app_fonts.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    this.formKey,
    this.recieveTime,
    this.changeDate,
    this.labelText,
    this.format,
    this.enableShowDayTime = false,
    this.isReadOnly = false,
    this.startDate,
    this.aboveTextStyle,
    this.textInnerStyle,
  });

  final GlobalKey<FormState>? formKey;
  final DateTime? recieveTime;
  final void Function(DateTime p1)? changeDate;
  final String? labelText;
  final String? format;
  final DateTime? startDate;
  final bool enableShowDayTime;
  final TextStyle? aboveTextStyle;
  final TextStyle? textInnerStyle;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      formKey: formKey,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "تاريخ الاستلام لا يمكن ان يكون خاليا ";
        }
        return null;
      },
      controller: TextEditingController(
          text: recieveTime != null
              ? DateFormat(format ?? 'd MMMM y', 'ar')
                  .format(recieveTime ?? DateTime.now())
              : ""),
      text: labelText ?? " تاريخ الاستلام ",
      enableBorder: true,
      readOnly: true,
     
      textStyle: aboveTextStyle ?? AppFontStyles.extraBoldNew16(context),
      textLabel: "",
      suffixIcon: IconButton(
        onPressed: !isReadOnly
            ? () {
                showDatePicker(
                        locale: const Locale('ar'),
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate:
                            startDate ?? DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 2))
                    .then((value) {
                  if (context.mounted && enableShowDayTime && value != null) {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((timeValue) {
                      if (value != null && timeValue != null) {
                        value = DateTime(value!.year, value!.month, value!.day,
                            timeValue.hour, timeValue.minute);
                        changeDate!(value!);
                      } else if (value != null && timeValue == null) {
                        changeDate!(value!);
                      }
                    });
                  } else {
                    if (value != null) {
                      changeDate!(value);
                    }
                  }
                });
              }
            : null,
        icon: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }
}
