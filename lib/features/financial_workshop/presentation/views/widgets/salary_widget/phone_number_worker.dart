import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberForWorker extends StatelessWidget {
  const PhoneNumberForWorker({
    super.key,
    this.workerModel,
    this.phoneController,
  });

  final WorkerModel? workerModel;
  final TextEditingController?phoneController;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "رقم الهاتف ",
      readOnly: !(workerModel?.enableEdit??true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(
              r'[0-9\u0660-\u0669\u06F0-\u06F9]'), // Allow Arabic and English numerals only
        )
      ],
      enableBorder: true,
      borderWidth: 2,
      controller: phoneController,
      textInputType: TextInputType.phone,
      initalText:phoneController!=null?null:workerModel?.workerPhone??"غير محدد",
      onChanged: (value) {
        workerModel?.workerPhone = value ?? "";
      },
      textLabel: '',
      maxLine: 1,
    );
  }
}
