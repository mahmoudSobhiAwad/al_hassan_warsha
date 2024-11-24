class ColorOrderModel {
  String colorId;
  String? colorName;
  int? colorDegree;
  String orderId;
  ColorOrderModel(
      {this.colorId = '',
      this.colorDegree,
      this.colorName,
      this.orderId=''});
  Map<String, dynamic> toJson({String? orderIdd}) {
    return {
      "colorId": colorId,
      "orderId": orderIdd??orderId,
      if (colorName != null) "colorName": colorName,
      if (colorDegree != null) "colorDegree": colorDegree,
    };
  }

  factory ColorOrderModel.fromJson(Map<String, dynamic> json) => ColorOrderModel(
        orderId: json['orderId'] as String,
        colorId: json['colorId'] as String,
        colorDegree:
            json["colorDegree"] != null ? json["colorDegree"] as int : null,
        colorName:
            json["colorName"] != null ? json["colorName"] as String : null,
      );
}
