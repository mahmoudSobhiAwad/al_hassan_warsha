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
    this.format
  });

  final GlobalKey<FormState>? formKey;
  final DateTime? recieveTime;
  final void Function(DateTime p1)? changeDate;
  final String? labelText;
  final String?format;

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
              ? DateFormat(format??'d MMMM y', 'ar')
                  .format(recieveTime ?? DateTime.now())
              : ""),
      text: labelText ?? " تاريخ الاستلام ",
      enableBorder: true,
      readOnly: true,
      textInnerStyle: AppFontStyles.extraBold18(context).copyWith(letterSpacing: 1),
      textStyle: AppFontStyles.extraBold18(context),
      textLabel: "",
      suffixIcon: IconButton(
        onPressed: () {
          changeDate != null
              ? showDatePicker(
                      locale: const Locale('ar'),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1))
                  .then((value) {
                  if (context.mounted) {
                    showTimePicker(
                      
                            context: context, initialTime: TimeOfDay.now())
                        .then((timeValue) {
                      if (value != null && timeValue != null) {
                        value = DateTime(value!.year, value!.month, value!.day,
                            timeValue.hour, timeValue.minute);
                        changeDate!(value!);
                      }
                    });
                  }
                })
              : null;
        },
        icon: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }
}
