import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:uuid/uuid.dart';

class WorkerModel {
  String? workerId;
  String workerName;
  String? workerPhone;
  SalaryType salaryType;
  String salaryAmount;
  DateTime? lastAddedSalary;
  bool isSelected;
  bool enableEdit;
  WorkerModel(
      {required this.workerId,
      this.salaryAmount = '0',
      this.isSelected = false,
      this.enableEdit = false,
      this.salaryType = SalaryType.monthly,
      this.workerName = '',
      this.lastAddedSalary,
      this.workerPhone});
  Map<String, dynamic> toJson() {
    return {
      "workerId": workerId,
      "workerName": workerName,
      "salaryType": salaryType.index,
      "salaryAmount": salaryAmount,
      if (workerPhone != null) "workerPhone": workerPhone,
      if (lastAddedSalary != null) "lastAddedSalary": lastAddedSalary!.toIso8601String(),
    };
  }

  Map<String, dynamic> toAddJson() {
    return {
      "workerId": const Uuid().v4(),
      "workerName": workerName,
      "salaryType": salaryType.index,
      "salaryAmount": convertToEnglishNumbers(salaryAmount),
      if (workerPhone != null) "workerPhone": workerPhone,
      if (lastAddedSalary != null) "lastAddedSalary": lastAddedSalary!.toIso8601String(),
    };
  }

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      workerId: json['workerId'] as String,
      salaryAmount: convertToArabicNumbers(json['salaryAmount'] as String),
      salaryType: SalaryType.values[json['salaryType'] as int],
      workerName: json['workerName'] as String,
      workerPhone:
          json['workerPhone'] != null ? json['workerPhone'] as String : null,
      lastAddedSalary: json['lastAddedSalary'] != null
          ? DateTime.parse(json['lastAddedSalary'] as String)
          : null,
    );
  }
}

enum SalaryType { daily, weekly, monthly }
