import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';

class OrderModel {
  String orderId;
  String orderName;
  String customerId;
  CustomerModel? customerModel;
  ColorOrderModel? colorModel;
  String? kitchenType;
  DateTime? recieveTime;
  String? notice;
  int mediaCounter;
  List<MediaOrderModel> mediaOrderList;
  List<ExtraInOrderModel> extraOrdersList;
  PillModel? pillModel;

  OrderModel(
      {this.mediaOrderList = const [],
      this.orderId='',
      this.pillModel,
      this.mediaCounter = 0,
      this.customerId='',
      this.customerModel,
      this.orderName='',
      this.recieveTime,
      this.notice,
      this.colorModel,
      this.kitchenType,
      this.extraOrdersList = const []});

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "orderName":orderName,
      "customerId": customerId,
      "mediaCounter": mediaCounter,
      "recieveTime": recieveTime?.toIso8601String(),
      if (notice != null) "notice": notice,
      if (kitchenType != null) "kitchenType": kitchenType,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json["orderId"] as String,
      orderName: json["orderName"] as String,
      recieveTime: DateTime.parse(json['recieveTime'] as String),
      kitchenType: json['kitchenType'] as String,
      notice: json['notice'] as String,
      mediaCounter: json['mediaCounter'] as int,
      customerId: json['customerId'] as String);
}
