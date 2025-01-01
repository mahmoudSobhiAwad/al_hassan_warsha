import 'package:al_hassan_warsha/features/financial_workshop/data/models/worker_model.dart';
import 'package:al_hassan_warsha/features/gallery/presentation/views/widgets/custom_text_form_with_text.dart';
import 'package:flutter/material.dart';

class WorkerName extends StatelessWidget {
  const WorkerName({
    super.key,
    this.workerModel,
    this.controller,
  });

  final WorkerModel? workerModel;
  final TextEditingController?controller;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextInAddNewType(
      text: "اسم الموظف ",
      enableBorder: true,
      borderWidth: 2,
      textLabel: '',
      maxLine: 1,
      initalText: controller!=null?null:workerModel?.workerName,
      readOnly:controller!=null?false:!(workerModel?.enableEdit??true),
      controller: controller,
      onChanged: (value) {
        workerModel?.workerName = value ?? "";
      },
     
    );
  }
}
