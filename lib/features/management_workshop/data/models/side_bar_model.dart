import 'package:al_hassan_warsha/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';


class SideBarManagementModel {
  Color backgroundColor;
  IconData? icon;
  String title;
  String numberOfItem;
  SideBarManagementModel(
      {required this.backgroundColor,
      required this.numberOfItem,
      this.icon,
      required this.title});
}

List<SideBarManagementModel> sideBarManagementItemList = [
  SideBarManagementModel(
      backgroundColor: AppColors.blueGray,
      numberOfItem: '8',
      title: 'العدد الكلي'),
  SideBarManagementModel(
      backgroundColor: AppColors.green,
      numberOfItem: '3',
      title: 'تم التسليم',
      icon: Icons.check),
  SideBarManagementModel(
      backgroundColor: AppColors.orange,
      numberOfItem: '3',
      title: 'اقترب تسليمه',
      icon: Icons.hourglass_empty_rounded),
  SideBarManagementModel(
      backgroundColor: AppColors.red,
      numberOfItem: '8',
      title: 'لم يتم تسليمه',
      icon: Icons.close_rounded),
];
