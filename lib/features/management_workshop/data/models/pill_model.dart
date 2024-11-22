class PillModel {
  String orderId;
  String pillId;
  double totalMoney;
  double interior;
  OptionPaymentWay optionPaymentWay;
  int stepsCounter;
  String customerName;
  PillModel({
    required this.customerName,
    required this.interior,
    required this.optionPaymentWay,
    required this.orderId,
    required this.pillId,
    required this.stepsCounter,
    required this.totalMoney,
  });
  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "pillId": pillId,
      "totalMoney": totalMoney,
      "interior": interior,
      "optionPaymentWay": optionPaymentWay.index,
      "stepsCounter": stepsCounter,
      "customerName": customerName,
    };
  }

  factory PillModel.fromJson(Map<String, dynamic> json) => PillModel(
      customerName: json["customerName"] as String,
      interior: json['interior'] as double,
      optionPaymentWay:
          OptionPaymentWay.values[json['optionPaymentWay'] as int],
      orderId: json['orderId'] as String,
      pillId: json['pillId'] as String,
      stepsCounter: json['stepsCounter'] as int,
      totalMoney: json['totalMoney'] as double);
}

enum OptionPaymentWay { atRecieve, onSteps }
