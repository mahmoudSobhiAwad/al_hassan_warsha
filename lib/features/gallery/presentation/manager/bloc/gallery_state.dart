part of 'gallery_bloc.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

final class LoadingCreateOrGetData extends GalleryState {}

final class SuccessCreateOrGetData extends GalleryState {
  final List<KitchenTypeModel>kitchenTypesList;
  SuccessCreateOrGetData({required this.kitchenTypesList});
  
}
final class FailureCreateOrGetData extends GalleryState {
  final String? errMessage;
  FailureCreateOrGetData({this.errMessage});
}

final class LoadingAddedNewKitchenType extends GalleryState {}

final class SuccessAddedNewKitchenType extends GalleryState {
  
}
final class FailureAddedNewKitchenType extends GalleryState {
  final String? errMessage;
  FailureAddedNewKitchenType({this.errMessage});
}


final class ShowMoreOfKitchenTypeState extends GalleryState {
  final bool showMore;
  ShowMoreOfKitchenTypeState({this.showMore=false});
}
