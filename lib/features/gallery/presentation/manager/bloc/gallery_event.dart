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
