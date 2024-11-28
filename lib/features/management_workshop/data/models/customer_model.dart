import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';

class CustomerModel {
  String customerId;
  String? customerName;
  String? phone;
  String? secondPhone;
  String? homeAddress;
  List<OrderModel> orderModelList;
  CustomerModel(
      {required this.customerId,
      this.customerName = '',
      this.orderModelList = const [],
      this.phone,
      this.homeAddress,
      this.secondPhone});
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      customerId: json['customerId'] as String,
      phone: json['phone'] != null ? json['phone'] as String : null,
      secondPhone:
          json['secondPhone'] != null ? json['secondPhone'] as String : null,
      homeAddress:
          json['homeAddress'] != null ? json['homeAddress'] as String : null,
      customerName: json['customerName'] as String);
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      if (phone != null) 'phone': phone,
      if (secondPhone != null) 'secondPhone': secondPhone,
      if (homeAddress != null) 'homeAddress': homeAddress,
    };
  }

  CustomerModel copyWith({
    String? customerId,
    String? customerName,
    String? phone,
    String? secondPhone,
    String? homeAddress,
    List<OrderModel>? orderModelList,
  }) {
    return CustomerModel(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      secondPhone: secondPhone ?? this.secondPhone,
      homeAddress: homeAddress ?? this.homeAddress,
    );
  }
  
}
