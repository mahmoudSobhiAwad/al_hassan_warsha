part of 'gallery_bloc.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

sealed class GalleryOutSideState extends GalleryState {}

final class LoadingCreateOrGetData extends GalleryState {}

final class SuccessCreateOrGetData extends GalleryState {
  final List<KitchenTypeModel>kitchenTypesList;
  SuccessCreateOrGetData({required this.kitchenTypesList});
  
}
final class FailureCreateOrGetData extends GalleryState {
  final String? errMessage;
  FailureCreateOrGetData({this.errMessage});
}

final class LoadingAddedNewKitchenType extends GalleryOutSideState {}

final class SuccessAddedNewKitchenType extends GalleryOutSideState {
  final String typeId;
  final String typeName;
  SuccessAddedNewKitchenType({required this.typeId,required this.typeName});
}
final class FailureAddedNewKitchenType extends GalleryOutSideState {
  final String? errMessage;
  FailureAddedNewKitchenType({this.errMessage});
}


final class ShowMoreOfKitchenTypeState extends GalleryState {
  
final int currIndex;
  ShowMoreOfKitchenTypeState({required this.currIndex});
}

final class AddNewKitchenState extends GalleryOutSideState{
  final KitchenModel kitchenModel;
  AddNewKitchenState({required this.kitchenModel});
}

final class RemoveKitchenState extends GalleryOutSideState{
  final String typeId;
  final String kitcehnId;
  RemoveKitchenState({required this.kitcehnId,required this.typeId});
}
