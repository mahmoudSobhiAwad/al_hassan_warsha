part of 'gallery_bloc.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}



sealed class GalleryOutSideState extends GalleryState {}

final class LoadingCreateOrGetData extends GalleryState {}

final class SuccessCreateOrGetData extends GalleryState {
  
  SuccessCreateOrGetData();
  
}
final class FailureCreateOrGetData extends GalleryState {
  final String? errMessage;
  FailureCreateOrGetData({this.errMessage});
}

final class LoadingAddedNewKitchenType extends GalleryOutSideState {}

final class SuccessAddedNewKitchenType extends GalleryOutSideState {

  SuccessAddedNewKitchenType();
}
final class FailureAddedNewKitchenType extends GalleryOutSideState {
  final String? errMessage;
  FailureAddedNewKitchenType({this.errMessage});
}


final class ShowMoreOfKitchenTypeState extends GalleryState {
  

  ShowMoreOfKitchenTypeState();
}

final class FetchKitchenTypeAfterChangeState extends GalleryOutSideState{
  
  FetchKitchenTypeAfterChangeState();
}

final class LoadingFetchMoreKitchenState extends GalleryState {}

final class SuccessFetchMoreKitchenState extends GalleryState {
 SuccessFetchMoreKitchenState();
}

final class FailureFetchMoreKitchenState extends GalleryState {
  final String? errMessage;
  FailureFetchMoreKitchenState({this.errMessage});
}
final class ChangeCurrentPageState extends GalleryState {}

final class ChangeSideBarActivationState extends GalleryState {}