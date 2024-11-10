part of 'gallery_bloc.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}
final class GalleryTestState extends GalleryState {}

final class ShowMoreOfKitchenTypeState extends GalleryState {
  final bool showMore;
  ShowMoreOfKitchenTypeState({this.showMore=false});
}
