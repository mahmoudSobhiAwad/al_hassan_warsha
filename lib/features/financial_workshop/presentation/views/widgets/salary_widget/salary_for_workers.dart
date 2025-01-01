import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalaryForWorker extends StatelessWidget {
  const SalaryForWorker({
    super.key,
    this.workerModel,
    this.controller,
  });

  final WorkerModel? workerModel;
  final TextEditingController?controller;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "الراتب",
      enableBorder: true,
      readOnly: !(workerModel?.enableEdit??true),
      controller:controller,
      initalText: controller!=null?null:workerModel?.salaryAmount,
      onChanged: (value) {
        workerModel?.salaryAmount = value ?? "";
      },
      borderWidth: 2,
      textLabel: '',
      textInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(
              r'[0-9\u0660-\u0669\u06F0-\u06F9]'), // Allow Arabic and English numerals only
        )
      ],
      maxLine: 1,
    );
  }
}
