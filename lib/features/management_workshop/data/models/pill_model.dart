import 'package:al_hassan_warsha/core/utils/functions/conver_en_to_ar.dart';

class PillModel {
  String orderId;
  String pillId;
  String totalMoney;
  String interior;
  String remian;
  String payedAmount;
  OptionPaymentWay optionPaymentWay;
  int stepsCounter;
  String customerName;
  String steppedAmount;
  PillModel({
    this.customerName = '',
    this.interior = "0",
    this.remian = "0",
    this.payedAmount = "0",
    this.steppedAmount='0',
    this.optionPaymentWay = OptionPaymentWay.atRecieve,
    this.orderId = '',
    this.pillId = '',
    this.stepsCounter = 1,
    this.totalMoney = "0",
  });
  Map<String, dynamic> toJson({String? orderIdd}) {
    return {
      "orderId": orderIdd ?? orderId,
      "pillId": pillId,
      "payedAmount": convertToEnglishNumbers(payedAmount).toString(),
      "totalMoney":convertToEnglishNumbers(totalMoney),
      "interior": convertToEnglishNumbers(interior),
      "optionPaymentWay": optionPaymentWay.index,
      "stepsCounter": stepsCounter,
      "customerName": customerName,
    };
  }

  factory PillModel.fromJson(Map<String, dynamic> json) => PillModel(
        customerName: json["customerName"] as String,
        interior: convertToArabicNumbers(json['interior'] as String),
        optionPaymentWay:
            OptionPaymentWay.values[json['optionPaymentWay'] as int],
        orderId: json['orderId'] as String,
        pillId: json['pillId'] as String,
        stepsCounter: json['stepsCounter'] as int,
        payedAmount: json['payedAmount'] as String,
        totalMoney: convertToArabicNumbers(json['totalMoney'] as String),
        remian: json['payedAmount'] != null
            ? (int.parse(json['totalMoney'] as String) -
                    (int.parse(json['interior'] as String) +
                        int.parse(json['payedAmount'] as String)))
                .toString()
            : '0',
      );
  PillModel copyWith({
    String? orderId,
    String? pillId,
    String? totalMoney,
    String? interior,
    String? remian,
    String? payedAmount,
    OptionPaymentWay? optionPaymentWay,
    int? stepsCounter,
    String? customerName,
  }) {
    return PillModel(
      orderId: orderId ?? this.orderId,
      pillId: pillId ?? this.pillId,
      totalMoney: totalMoney ?? this.totalMoney,
      interior: interior ?? this.interior,
      remian: remian ?? this.remian,
      payedAmount: payedAmount ?? this.payedAmount,
      optionPaymentWay: optionPaymentWay ?? this.optionPaymentWay,
      stepsCounter: stepsCounter ?? this.stepsCounter,
      customerName: customerName ?? this.customerName,
    );
  }
}

enum OptionPaymentWay { atRecieve, onSteps }
