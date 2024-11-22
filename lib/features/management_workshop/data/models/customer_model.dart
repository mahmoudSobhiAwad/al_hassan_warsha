import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';

class CustomerModel {
  String customerId;
  String customerName;
  String? phone;
  String? secondPhone;
  List<OrderModel> orderModelList;
  CustomerModel(
      {required this.customerId,
      required this.customerName,
      this.orderModelList = const [],
      this.phone,
      this.secondPhone});
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      customerId: json['customerId'] as String,
      phone: json['phone'] as String,
      secondPhone: json['secondPhone'] as String,
      customerName: json['customerName'] as String);
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      if (phone != null) 'phone': phone,
      if (phone != null) 'secondPhone': secondPhone,
    };
  }
}
