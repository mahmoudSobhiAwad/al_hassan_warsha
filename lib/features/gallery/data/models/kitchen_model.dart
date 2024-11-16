class KitchenModel {
  String?kitchenName;
  String?kitchenDesc;
  String kitchenId;
  String typeId;
  List<KitchenMedia>?kitchenMediaList;
  KitchenModel({required this.kitchenId,required this.typeId,this.kitchenMediaList,this.kitchenDesc,this.kitchenName});
  
}

class KitchenMedia{
  String path;
  MediaType mediaType;
  String?kitchenId;
  KitchenMedia({required this.mediaType,required this.path,this.kitchenId});
}

enum MediaType {image,video}