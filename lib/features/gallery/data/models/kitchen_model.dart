class KitchenModel {
  String? kitchenName;
  String? kitchenDesc;
  String kitchenId;
  String typeId;
  DateTime addedDate;
  int mediaCounter;
  List<KitchenMedia> kitchenMediaList;
  KitchenModel(
      {required this.kitchenId,
      required this.typeId,
      required this.addedDate,
      required this.mediaCounter,
      this.kitchenMediaList = const [],
      this.kitchenDesc,
      this.kitchenName});

  Map<String, dynamic> toJson() {
    return {
      'kitchenId': kitchenId,
      'kitchenName': kitchenName,
      'kitchenDesc': kitchenDesc,
      'typeId': typeId,
      "addedTime": addedDate.toIso8601String(),
      "mediaCounter":mediaCounter,
    };
  }
  List<PickedMedia>getPickedMedia(){
    List<PickedMedia>list=[];
    for(var item in  kitchenMediaList){
      list.add(PickedMedia(mediaPath: item.path, mediaType: item.mediaType, mediId: item.kitchenMediaId));
    }
    return list;
  }
  

  factory KitchenModel.fromJson(Map<String, dynamic> json,
      ) {
    return KitchenModel(
      
      addedDate: DateTime.parse(json["addedTime"] as String),
      kitchenId: json['kitchenId'] as String,
      kitchenName: json['kitchenName'] as String,
      kitchenDesc:
          json['kitchenDesc'] == null ? "" : json['kitchenDesc'] as String,
      typeId: json['typeId'] == null ? "" : json['typeId'] as String,
      mediaCounter: json['mediaCounter'] as int,
    );
  }
}

class KitchenMedia {
  String kitchenMediaId;
  String path;
  MediaType mediaType;
  String kitchenId;
  
  KitchenMedia(
      {required this.mediaType,
      required this.path,
      required this.kitchenId,
      
      required this.kitchenMediaId});
  Map<String, dynamic> toJson() {
    return {
      'kitchenMediaId': kitchenMediaId,
      'path': path,
      'mediaType': mediaType.index,
      'kitchenId': kitchenId,
      
    };
  }

  factory KitchenMedia.fromJson(Map<String, dynamic> json) {
   
    return KitchenMedia(
      kitchenMediaId: json["kitchenMediaId"] as String,
      path: json['path'] as String,
      mediaType: MediaType.values[json['mediaType'] as int],
      kitchenId: json['kitchenId'] as String,
      
    );
  }
}

enum MediaType { image, video,unknown }

class PickedMedia {
  String mediaPath;
  String mediId;
  MediaType mediaType;
  PickedMedia({required this.mediaPath, required this.mediaType,required this.mediId});

  KitchenMedia intoKitchenMedia(String kitchenID){
    return KitchenMedia(mediaType: mediaType, path: mediaPath, kitchenId: kitchenID, kitchenMediaId: mediId);
  }
}
