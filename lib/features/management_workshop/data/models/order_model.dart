import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
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
  OrderStatus? orderStatus;

  OrderModel(
      {this.mediaOrderList = const [],
      this.orderId = '',
      this.pillModel,
      this.mediaCounter = 0,
      this.customerId = '',
      this.customerModel,
      this.orderName = '',
      this.recieveTime,
      this.orderStatus,
      this.notice,
      this.colorModel,
      this.kitchenType,
      this.extraOrdersList = const []});

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "orderName": orderName,
      "customerId": customerId,
      "mediaCounter": mediaCounter,
      "recieveTime": recieveTime?.toIso8601String(),
      if (notice != null) "notice": notice,
      if (kitchenType != null) "kitchenType": kitchenType,
      if (orderStatus != null) "orderStatus": orderStatus!.index,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json["orderId"] as String,
      orderName: json["orderName"] as String,
      recieveTime: DateTime.parse(json['recieveTime'] as String),
      orderStatus: json['orderStatus'] as int == 2
          ? OrderStatus.finished
          : getOrderStatus(DateTime.tryParse(json['recieveTime'] as String) ??
              DateTime.now()),
      kitchenType:
          json['kitchenType'] != null ? json['kitchenType'] as String : null,
      notice: json['notice'] != null ? json['notice'] as String : null,
      mediaCounter: json['mediaCounter'] as int,
      customerId: json['customerId'] as String);

  OrderModel copyWith({
    String? orderId,
    String? customerId,
    String? orderName,
    CustomerModel? customerModel,
    ColorOrderModel? colorModel,
    OrderStatus? orderStatus,
    String? kitchenType,
    DateTime? recieveTime,
    String? notice,
    int? mediaCounter,
    List<MediaOrderModel>? mediaOrderList,
    List<ExtraInOrderModel>? extraOrdersList,
    PillModel? pillModel,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      orderStatus: orderStatus ?? this.orderStatus,
      orderName: orderName ?? this.orderName,
      customerId: customerId ?? this.customerId,
      customerModel: customerModel ??
          this.customerModel?.copyWith(), // Clone customerModel
      colorModel: colorModel ?? this.colorModel?.copyWith(), // Clone colorModel
      kitchenType: kitchenType ?? this.kitchenType,
      recieveTime: recieveTime ?? this.recieveTime,
      notice: notice ?? this.notice,
      mediaCounter: mediaCounter ?? this.mediaCounter,
      mediaOrderList: mediaOrderList ??
          this
              .mediaOrderList
              .map((item) => item.copyWith())
              .toList(), // Clone each item
      extraOrdersList: extraOrdersList ??
          this
              .extraOrdersList
              .map((item) => item.copyWith())
              .toList(), // Clone each item
      pillModel: pillModel ?? this.pillModel?.copyWith(), // Clone pillModel
    );
  }

  List<PickedMedia> getPickedMedia() {
    List<PickedMedia> list = [];
    for (var item in mediaOrderList) {
      list.add(PickedMedia(
          mediaPath: item.mediaPath,
          mediaType: item.mediaType,
          mediId: item.mediaId));
    }
    return list;
  }
}

enum OrderStatus { neverDone, veryNear, finished }

OrderStatus getOrderStatus(DateTime recieveTime) {
  OrderStatus status = recieveTime.difference(DateTime.now()).inDays.abs() <= 3
      ? OrderStatus.veryNear
      : OrderStatus.neverDone;
  return status;
}
