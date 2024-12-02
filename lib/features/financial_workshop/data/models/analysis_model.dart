import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';
import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalysisModel {
  String title;
  String moneyQuantity;
  IconData iconData;
  Color color;
  int index;
  AnalysisModel(
      {required this.color,
      this.index = -1,
      required this.iconData,
      required this.moneyQuantity,
      required this.title});
}

List<AnalysisModel> getAnalysisList(AnalysisModelData analysisModelData) {
  return [
    AnalysisModel(
        color: AppColors.blue,
        index: 0,
        iconData: FontAwesomeIcons.database,
        moneyQuantity: convertToArabicNumbers(
            analysisModelData.allRecievedAmount.toString()),
        title: "العائد الكلي"),
    AnalysisModel(
        color: AppColors.green,
        index: 1,
        iconData: Icons.arrow_upward_rounded,
        moneyQuantity:
            convertToArabicNumbers(analysisModelData.profitAmount.toString()),
        title: "الربح"),
    AnalysisModel(
        color: AppColors.orange,
        iconData: Icons.sell_rounded,
        index: 2,
        moneyQuantity:
            convertToArabicNumbers(analysisModelData.allBuysAmount.toString()),
        title: "المشتريات"),
    AnalysisModel(
        color: AppColors.red,
        index: 3,
        iconData: Icons.money_rounded,
        moneyQuantity: convertToArabicNumbers(
            analysisModelData.allSalaryAmount.toString()),
        title: "مرتبات"),
    AnalysisModel(
        index: 4,
        color: AppColors.blueGray,
        iconData: Icons.production_quantity_limits_rounded,
        moneyQuantity:
            convertToArabicNumbers(analysisModelData.allPillAmount.toString()),
        title: "فواتير اخري"),
  ];
}

class AnalysisModelData {
  int allRecievedAmount;
  int profitAmount;
  int allBuysAmount;
  int allPillAmount;
  int allSalaryAmount;
  AnalysisModelData(
      {this.allBuysAmount = 0,
      this.allSalaryAmount = 0,
      this.allPillAmount = 0,
      this.allRecievedAmount = 0,
      this.profitAmount = 0});
}
