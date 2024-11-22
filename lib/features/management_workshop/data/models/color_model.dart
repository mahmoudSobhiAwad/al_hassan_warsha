class ColorModel {
  String colorId;
  String? colorName;
  int? colorDegree;
  String orderId;
  ColorModel(
      {required this.colorId,
      this.colorDegree,
      this.colorName,
      required this.orderId});
  Map<String, dynamic> toJson() {
    return {
      "colorId": colorId,
      "orderId": orderId,
      if (colorName != null) "colorName": colorName,
      if (colorDegree != null) "colorDegree": colorDegree,
    };
  }

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        orderId: json['orderId'] as String,
        colorId: json['colorId'] as String,
        colorDegree:
            json["colorDegree"] != null ? json["colorDegree"] as int : null,
        colorName:
            json["colorName"] != null ? json["colorName"] as String : null,
      );
}
