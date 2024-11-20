import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';

class KitchenTypeModel {
  String typeName;
  String typeId;
  int itemsCount;
  List<KitchenModel> kitchenList;
  List<OnlyTypeModel> onlyTypeModelList;
  KitchenTypeModel(
      {this.itemsCount = 0,
      required this.typeId,
      required this.typeName,
      this.onlyTypeModelList = const [],
      this.kitchenList = const []});
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'typeName': typeName,
      'itemsCount': itemsCount,
    };
  }

  factory KitchenTypeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return KitchenTypeModel(
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      itemsCount: json['itemsCount'] as int,
    );
  }
}

class OnlyTypeModel {
  String typeName;
  String typeId;
  int itemsCount;
  OnlyTypeModel(
      {required this.itemsCount, required this.typeId, required this.typeName});
  factory OnlyTypeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OnlyTypeModel(
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      itemsCount: json['itemsCount'] as int,
    );
  }
}
