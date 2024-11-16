class KitchenTypeModel {
  String typeName;
  String typeId;
  int itemsCount;
  KitchenTypeModel({this.itemsCount=0,required this.typeId,required this.typeName});
   Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'typeName': typeName,
      'itemsCount': itemsCount,
    };
  }

  factory KitchenTypeModel.fromJson(Map<String, dynamic> json) {
    return KitchenTypeModel(
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      itemsCount: json['itemsCount'] as int,
    );
  }
}
