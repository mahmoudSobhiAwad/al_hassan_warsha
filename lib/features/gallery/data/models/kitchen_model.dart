class KitchenModel {
  String?kitchenName;
  String?kitchenDesc;
  String kitchenId;
  String typeId;
  DateTime addedDate;
  List<KitchenMedia>kitchenMediaList;
  KitchenModel({required this.kitchenId,required this.typeId,required this.addedDate,this.kitchenMediaList=const [],this.kitchenDesc,this.kitchenName});
  
  Map<String, dynamic> toJson() {
    return {
      'kitchenId': kitchenId,
      'kitchenName': kitchenName,
      'kitchenDesc': kitchenDesc,
      'typeId': typeId,
      "addedTime":addedDate.toIso8601String(),
     if(kitchenMediaList.isNotEmpty) "kitchenMediaList": kitchenMediaList.map((item) => item.toJson()).toList(),
    };
  }

  factory KitchenModel.fromJson(Map<String, dynamic> json) {
    return KitchenModel(
      addedDate: DateTime.parse(json["addedTime"] as String),
      kitchenId: json['kitchenId'] as String,
      kitchenName: json['kitchenName'] as String,
      kitchenDesc: json['kitchenDesc']==null?"":json['kitchenDesc'] as String,
      typeId: json['typeId'] as String,
      kitchenMediaList: (json['kitchenMediaList'] as List<dynamic>?)
          ?.map((item) => KitchenMedia.fromJson(item))
          .toList()??[], 
    );
  }
}

class KitchenMedia{
  String path;
  MediaType mediaType;
  String?kitchenId;
  KitchenMedia({required this.mediaType,required this.path,this.kitchenId});
   Map<String, dynamic> toJson() {
    return {
      'path': path,
      'mediaType': mediaType.index, // Store the enum as an integer
      'kitchenId': kitchenId,
    };
  }

  // Convert from a Map fetched from the database
  factory KitchenMedia.fromJson(Map<String, dynamic> json) {
    return KitchenMedia(
      path: json['path'] as String,
      mediaType: MediaType.values[json['mediaType'] as int], // Convert back to enum
      kitchenId: json['kitchenId'] as String,
    );
  }
}

enum MediaType {image,video}