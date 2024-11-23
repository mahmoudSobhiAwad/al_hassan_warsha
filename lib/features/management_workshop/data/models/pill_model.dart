class PillModel {
  String orderId;
  String pillId;
  String totalMoney;
  String interior;
  OptionPaymentWay optionPaymentWay;
  int stepsCounter;
  String customerName;
  PillModel({
     this.customerName='',
     this.interior="0.0",
     this.optionPaymentWay=OptionPaymentWay.atRecieve,
     this.orderId='',
     this.pillId='',
     this.stepsCounter=0,
     this.totalMoney="0.0",
  });
  Map<String, dynamic> toJson({required String orderIdd}) {
    return {
      "orderId": orderIdd,
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
      interior: json['interior'] as String,
      optionPaymentWay:
          OptionPaymentWay.values[json['optionPaymentWay'] as int],
      orderId: json['orderId'] as String,
      pillId: json['pillId'] as String,
      stepsCounter: json['stepsCounter'] as int,
      totalMoney: json['totalMoney'] as String);
}

enum OptionPaymentWay { atRecieve, onSteps }
