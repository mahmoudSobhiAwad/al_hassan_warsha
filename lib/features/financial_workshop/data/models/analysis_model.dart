import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalysisModel {
  String title;
  String moneyQuantity;
  IconData iconData;
  Color color;
  AnalysisModel({
    required this.color,
    required this.iconData,
    required this.moneyQuantity,
    required this.title
  });
}
List<AnalysisModel>analysisList=[
  AnalysisModel(color: AppColors.blue, iconData: FontAwesomeIcons.database, moneyQuantity: "100000 جنية", title: "العائد الكلي"),
  AnalysisModel(color: AppColors.green, iconData: Icons.arrow_upward_rounded, moneyQuantity: "50000 جنية", title: "الربح"),
  AnalysisModel(color: AppColors.orange, iconData: Icons.sell_rounded, moneyQuantity: "100000 جنية", title: "المشتريات"),
  AnalysisModel(color: AppColors.red, iconData: Icons.money_rounded, moneyQuantity: "100000 جنية", title: "مرتبات"),
  AnalysisModel(color: AppColors.blueGray, iconData: Icons.production_quantity_limits_rounded, moneyQuantity: "100000 جنية", title: "فواتير اخري"),
];