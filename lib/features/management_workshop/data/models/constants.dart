import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:flutter/material.dart';

const String orderTableName = 'orderTable';
const String customerTableName = 'customer';
const String kitchenTypesInOrder = 'kitchenTypesInOrder';
const String colorTableName = 'colorTable';
const String mediaOrderTableName = 'mediaOrder';
const String extraOrderTableName = 'extraOrder';
const String pillTableName = 'pillTable';

class MonthModel {
  String monthName;
  int monthValue;
  MonthModel({required this.monthName, required this.monthValue});
}

class SearchModel {
  String valueArSearh;
  String valueEnSearh;
  SearchModel({required this.valueArSearh, required this.valueEnSearh});
}

List<MonthModel> monthModelList = [
  MonthModel(monthName: 'يناير', monthValue: 1),
  MonthModel(monthName: 'فبراير', monthValue: 2),
  MonthModel(monthName: 'مارس', monthValue: 3),
  MonthModel(monthName: 'أبريل', monthValue: 4),
  MonthModel(monthName: 'مايو', monthValue: 5),
  MonthModel(monthName: 'يونيو', monthValue: 6),
  MonthModel(monthName: 'يوليو', monthValue: 7),
  MonthModel(monthName: 'أغسطس', monthValue: 8),
  MonthModel(monthName: 'سبتمبر', monthValue: 9),
  MonthModel(monthName: 'أكتوبر', monthValue: 10),
  MonthModel(monthName: 'نوفمبر', monthValue: 11),
  MonthModel(monthName: 'ديسمبر', monthValue: 12),
];

List<SearchModel> searchListInOrders = [
  SearchModel(valueArSearh: "اسم العميل", valueEnSearh: "customerName"),
  SearchModel(valueArSearh: " رقم الهاتف", valueEnSearh: "phone"),
  SearchModel(valueArSearh: "اسم الطلب", valueEnSearh: "orderName"),
  SearchModel(valueArSearh: " عنوان العميل", valueEnSearh: "homeAddress"),
  SearchModel(valueArSearh: "نوع المطبخ", valueEnSearh: "kitchenType"),
];

enum MoreVertAction { edit, delete, viewProfile, deliver, notDeliever }

class MoreVerModel {
  String text;
  IconData icon;
  MoreVertAction moreVertEnum;
  MoreVerModel(
      {required this.icon, required this.moreVertEnum, required this.text});
}

List<MoreVerModel> moreVerList(OrderStatus orderStatus) {
  return [
    MoreVerModel(
        icon: Icons.edit, moreVertEnum: MoreVertAction.edit, text: "تعديل "),
    MoreVerModel(
        icon: Icons.delete, moreVertEnum: MoreVertAction.delete, text: "حذف "),
    MoreVerModel(
        icon: Icons.person,
        moreVertEnum: MoreVertAction.viewProfile,
        text: "عرض الملف الشخصي"),
    orderStatus == OrderStatus.finished
        ? MoreVerModel(
            icon: Icons.restart_alt_outlined,
            moreVertEnum: MoreVertAction.notDeliever,
            text: " عدم تسليم الطلب")
        : MoreVerModel(
            icon: Icons.check,
            moreVertEnum: MoreVertAction.deliver,
            text: " تسليم الطلب"),
  ];
}
