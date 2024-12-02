import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';

List<SearchModel> searchListInFinanical = [
  SearchModel(valueArSearh: "اسم العميل", valueEnSearh: "customerName"),
  SearchModel(valueArSearh: "اسم الطلب", valueEnSearh: "orderName"),
];
List<SearchModel> allTransactionTypesList = [
  SearchModel(valueArSearh: "مقدم", valueEnSearh: AllTransactionTypes.interior),
  SearchModel(
      valueArSearh: "تنزيل قسط", valueEnSearh: AllTransactionTypes.stepDown),
  SearchModel(
      valueArSearh: "مرتبات", valueEnSearh: AllTransactionTypes.salaries),
  SearchModel(
      valueArSearh: " فواتير", valueEnSearh: AllTransactionTypes.pills),
  SearchModel(
      valueArSearh: " مشتريات", valueEnSearh: AllTransactionTypes.buys),
  SearchModel(
      valueArSearh: " اخري", valueEnSearh: AllTransactionTypes.other),
];
