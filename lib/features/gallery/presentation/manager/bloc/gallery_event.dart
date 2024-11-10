part of 'gallery_bloc.dart';

@immutable
sealed class GalleryEvent {}
final class ShowMoreKitcenTypeEvent extends GalleryEvent {
  final bool showMore;
  ShowMoreKitcenTypeEvent({this.showMore=false});
}

