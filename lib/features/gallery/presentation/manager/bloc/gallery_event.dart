part of 'gallery_bloc.dart';

@immutable
sealed class GalleryEvent {}
final class ShowMoreKitcenTypeEvent extends GalleryEvent {
  final String typeId;
  final int currIndex;
  final bool isOpen;
  ShowMoreKitcenTypeEvent({required this.currIndex,this.typeId="",required this.isOpen});
}
final class AddNewKitchenTypeEvent extends GalleryEvent {}

final class GetAllGalleryDataEvent extends GalleryEvent {}

final class FetchKitchenTypeAfterChangeEvent extends GalleryEvent {
  final String typeId;
  FetchKitchenTypeAfterChangeEvent({required this.typeId});
}

final class UpdateCatchDataEvent extends GalleryEvent {
  final List<KitchenTypeModel>kitchenList;
  UpdateCatchDataEvent({required this.kitchenList});
}
final class FetchMoreTypesEvent extends GalleryEvent {
  
  FetchMoreTypesEvent();
}
final class ChangePageIndexInShowMoreEvent extends GalleryEvent {
  final int index;
  ChangePageIndexInShowMoreEvent({required this.index});
}
final class DefineTimerFunctionEvent extends GalleryEvent {
}