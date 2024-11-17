import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';

class KitchenTypeModel {
  String typeName;
  String typeId;
  int itemsCount;
  List<KitchenModel> kitchenList;
  KitchenTypeModel(
      {this.itemsCount = 0,
      required this.typeId,
      required this.typeName,
      this.kitchenList = const []});
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'typeName': typeName,
      'itemsCount': itemsCount,
      if (kitchenList.isNotEmpty)
        'kitchens': kitchenList.map((kitchen) => kitchen.toJson()).toList(),
    };
  }

  factory KitchenTypeModel.fromJson(Map<String, dynamic> json,{List<dynamic> kitchensList=const []}) {
    return KitchenTypeModel(
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      itemsCount: json['itemsCount'] as int,
      kitchenList: kitchensList
              .map((kitchenJson) => KitchenModel.fromJson(kitchenJson))
              .toList(),
          
    );
  }
}
