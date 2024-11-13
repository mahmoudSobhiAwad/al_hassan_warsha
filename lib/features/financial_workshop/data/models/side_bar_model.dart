import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FinancialSideBarModel {
  String title;
  IconData iconData;

  FinancialSideBarModel({required this.iconData, required this.title});
}

List<FinancialSideBarModel> financialSideBarList = [
  FinancialSideBarModel(
      iconData: FontAwesomeIcons.database, title: "فواتير العملاء"),
  FinancialSideBarModel(iconData: Icons.swap_horiz_rounded, title: "التحويلات"),
  FinancialSideBarModel(iconData: FontAwesomeIcons.receipt, title: "مرتبات"),
  FinancialSideBarModel(iconData: Icons.show_chart_rounded, title: "تحليل"),
];
