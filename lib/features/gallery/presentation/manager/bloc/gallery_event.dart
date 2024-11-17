part of 'gallery_bloc.dart';

@immutable
sealed class GalleryEvent {}
final class ShowMoreKitcenTypeEvent extends GalleryEvent {
  final bool showMore;
  ShowMoreKitcenTypeEvent({this.showMore=false});
}
final class AddNewKitchenTypeEvent extends GalleryEvent {
  final String typeName;
  AddNewKitchenTypeEvent({required this.typeName});
}

final class CheckExistOfGalleryDataEvent extends GalleryEvent {}

final class AddNewKitchenFromGalleryEvent extends GalleryEvent {
  final KitchenModel kitchenModel;
  AddNewKitchenFromGalleryEvent({required this.kitchenModel});
}

final class ReomveKitchenFromGalleryEvent extends GalleryEvent {
  final String kitchenId;
  final String typeId;
  ReomveKitchenFromGalleryEvent({required this.kitchenId,required this.typeId});
}
final class UpdateCatchDataEvent extends GalleryEvent {
  final List<KitchenTypeModel>kitchenList;
  UpdateCatchDataEvent({required this.kitchenList});
}