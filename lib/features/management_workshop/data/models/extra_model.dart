import 'package:uuid/uuid.dart';

class ExtraInOrderModel {
  String extraName;
  String orderId;
  String extraId;
  ExtraInOrderModel(
      {required this.extraId, required this.extraName, this.orderId=''});

  Map<String, dynamic> toEditJson() {
    return {
      "extraName": extraName,
      "orderId": orderId,
      "extraId": extraId,
    };
  }
  Map<String, dynamic> toAddJson({required String orderIdd}) {
    return {
      "extraName": extraName,
      "orderId": orderIdd,
      "extraId":const Uuid().v4(),
    };
  }

  factory ExtraInOrderModel.fromJson(Map<String, dynamic> json) =>
      ExtraInOrderModel(
          extraId: json['extraId'] as String,
          extraName: json['extraName'] as String,
          orderId: json['orderId'] as String);
}
