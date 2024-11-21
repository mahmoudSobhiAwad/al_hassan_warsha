part of 'media_gallery_grid_cubit.dart';

@immutable
sealed class MediaGalleryGridState {}

final class MediaGalleryGridInitial extends MediaGalleryGridState {}

final class LoadingGalleryGridState extends MediaGalleryGridState {}

final class SuccessGalleryGridState extends MediaGalleryGridState {}

final class FailureGalleryGridState extends MediaGalleryGridState {
  final String? errMessage;
  FailureGalleryGridState({required this.errMessage});
}
