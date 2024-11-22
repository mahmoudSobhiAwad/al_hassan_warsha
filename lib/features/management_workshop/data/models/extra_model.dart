class ExtraInOrderModel {
  String extraName;
  String orderId;
  String extraId;
  ExtraInOrderModel(
      {required this.extraId, required this.extraName, required this.orderId});

  Map<String, dynamic> toJson() {
    return {
      "extraName": extraName,
      "orderId": orderId,
      "extraId": extraId,
    };
  }

  factory ExtraInOrderModel.fromJson(Map<String, dynamic> json) =>
      ExtraInOrderModel(
          extraId: json['extraId'] as String,
          extraName: json['extraName'] as String,
          orderId: json['orderId'] as String);
}
