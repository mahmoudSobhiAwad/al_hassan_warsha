import 'package:uuid/uuid.dart';

class TransactionModel {
  String? transactionId;
  String transactionName;
  String transactionAmount;
  TransactionType transactionType;
  TransactionMethod transactionMethod;
  DateTime? transactionTime;
  TransactionModel(
      {this.transactionId = '',
      this.transactionAmount = '0',
      this.transactionMethod = TransactionMethod.caching,
      this.transactionName = '',
      this.transactionType = TransactionType.recieve,
      this.transactionTime});

  Map<String, dynamic> toJson() {
    return {
      "transactionId": transactionId,
      "transactionName": transactionName,
      "transactionAmount": transactionAmount,
      "transactionTime": transactionTime?.toIso8601String(),
      "transactionType": transactionType.index,
      "transactionMethod": transactionMethod.index,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        transactionId: json['transactionId'] as String,
        transactionAmount: json['transactionAmount'] as String,
        transactionMethod:
            TransactionMethod.values[json['transactionMethod'] as int],
        transactionName: json['transactionName'] as String,
        transactionType: TransactionType.values[json['transactionType'] as int],
        transactionTime: DateTime.parse(json['transactionTime'] as String));
  }
  TransactionModel clear({
    String? transactionId,
    String? transactionName,
    String? transactionAmount,
    TransactionType? transactionType,
    TransactionMethod? transactionMethod,
    DateTime? transactionTime,
  }) {
    return TransactionModel(
      transactionAmount: "0",
      transactionId: "" ,
      transactionMethod: TransactionMethod.caching ,
      transactionName: "" ,
      transactionTime: DateTime.now() ,
      transactionType: TransactionType.recieve,
    );
  }
}

enum TransactionType { recieve, buy }

enum TransactionMethod { caching, visa }
