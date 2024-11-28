import 'package:uuid/uuid.dart';

class ExtraInOrderModel {
  String extraName;
  String orderId;
  String extraId;
  ExtraInOrderModel(
      {required this.extraId, required this.extraName, this.orderId = ''});

  Map<String, dynamic> toAddJson({String? orderIdd}) {
    return {
      "extraName": extraName,
      "orderId": orderIdd ?? orderId,
      "extraId": const Uuid().v4(),
    };
  }

  factory ExtraInOrderModel.fromJson(Map<String, dynamic> json) =>
      ExtraInOrderModel(
          extraId: json['extraId'] as String,
          extraName: json['extraName'] as String,
          orderId: json['orderId'] as String);
  ExtraInOrderModel copyWith({
    String? extraName,
    String? orderId,
    String? extraId,
  }) {
    return ExtraInOrderModel(
      extraName: extraName ?? this.extraName,
      orderId: orderId ?? this.orderId,
      extraId: extraId ?? this.extraId,
    );
  }
}
