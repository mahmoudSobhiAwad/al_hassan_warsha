import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';

class MediaOrderModel {
  String mediaId;
  String orderId;
  String mediaPath;
  MediaType mediaType;
  MediaOrderModel(
      {required this.mediaId,
      required this.mediaPath,
      required this.mediaType,
      required this.orderId});

  Map<String, dynamic> toAddJson({String? orderIdd}) {
    return {
      "mediaId": mediaId,
      "orderId": orderIdd ?? orderId,
      "mediaPath": mediaPath,
      "mediaType": mediaType.index,
    };
  }

  factory MediaOrderModel.fromJson(Map<String, dynamic> json) =>
      MediaOrderModel(
          mediaId: json['mediaId'] as String,
          mediaPath: json["mediaPath"]!=null?json["mediaPath"]! as String: "",
          mediaType: MediaType.values[json['mediaType'] as int],
          orderId: json['orderId'] as String);
 
 
  MediaOrderModel copyWith({
    String? mediaId,
    String? orderId,
    String? mediaPath,
    MediaType? mediaType,
  }) {
    return MediaOrderModel(
      mediaId: mediaId ?? this.mediaId,
      orderId: orderId ?? this.orderId,
      mediaPath: mediaPath ?? this.mediaPath,
      mediaType: mediaType ?? this.mediaType,
    );
  }
}
