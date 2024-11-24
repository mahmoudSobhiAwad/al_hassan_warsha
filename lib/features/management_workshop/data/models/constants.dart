const String orderTableName = 'orderTable';
const String customerTableName = 'customer';
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

List<SearchModel> searchList = [
  SearchModel(valueArSearh: "اسم العميل", valueEnSearh: "customerName"),
  SearchModel(valueArSearh: " رقم الهاتف", valueEnSearh: "phone"),
  SearchModel(valueArSearh: "اسم الطلب", valueEnSearh: "orderName"),
  SearchModel(valueArSearh: " عنوان العميل", valueEnSearh: "homeAddress"),
  SearchModel(valueArSearh: "نوع المطبخ", valueEnSearh: "kitchenType"),
];
