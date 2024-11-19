part of 'gallery_bloc.dart';

@immutable
sealed class GalleryEvent {}
final class ShowMoreKitcenTypeEvent extends GalleryEvent {
  final bool showMore;
  final int currIndex;
  ShowMoreKitcenTypeEvent({this.showMore=false,required this.currIndex});
}
final class AddNewKitchenTypeEvent extends GalleryEvent {
  final String typeName;
  AddNewKitchenTypeEvent({required this.typeName});
}

final class CheckExistOfGalleryDataEvent extends GalleryEvent {}

final class FetchKitchenTypeAfterChangeEvent extends GalleryEvent {
  final String typeId;
  FetchKitchenTypeAfterChangeEvent({required this.typeId});
}

final class UpdateCatchDataEvent extends GalleryEvent {
  final List<KitchenTypeModel>kitchenList;
  UpdateCatchDataEvent({required this.kitchenList});
}