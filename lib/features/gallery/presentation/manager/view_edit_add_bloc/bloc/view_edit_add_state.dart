part of 'view_edit_add_bloc.dart';

@immutable
sealed class ViewEditAddState {}

final class ViewEditAddInitial extends ViewEditAddState {}

final class ChangeBarIndexState extends ViewEditAddState {
  final int barIndex;
  ChangeBarIndexState({required this.barIndex});
}

final class ToggleBetweenEditAndViewState extends ViewEditAddState {
  final bool enableOpen;
  ToggleBetweenEditAndViewState({required this.enableOpen});
}
final class LoadingAddNewKitchenState extends ViewEditAddState {}

final class FailureAddNewKitchenState extends ViewEditAddState {
  final String?errMessage;
  FailureAddNewKitchenState({this.errMessage});
}

final class SuccessAddNewKitchenState extends ViewEditAddState {
  final KitchenModel model;
  SuccessAddNewKitchenState({required this.model});
}

final class ClearDataAfterAddState extends ViewEditAddState {}

final class LoadingDeleteNewKitchenState extends ViewEditAddState {}

final class FailureDeleteNewKitchenState extends ViewEditAddState {
  final String?errMessage;
  FailureDeleteNewKitchenState({this.errMessage});
}

final class SuccessDeleteNewKitchenState extends ViewEditAddState {
  final String typeId;
  SuccessDeleteNewKitchenState({required this.typeId});
}

final class LoadingEditKitchenState extends ViewEditAddState {}

final class FailureEditKitchenState extends ViewEditAddState {
  final String?errMessage;
  FailureEditKitchenState({this.errMessage});
}

final class SuccessEditKitchenState extends ViewEditAddState {
  final String typeId;
  SuccessEditKitchenState({required this.typeId});
}

final class LoadingAddMediaState extends ViewEditAddState{}

final class FailureAddMediaState extends ViewEditAddState{
  final String? errMessage;
  FailureAddMediaState({this.errMessage});
}

final class SuccessAddMediaState extends ViewEditAddState{
  final List<PickedMedia>list;
  SuccessAddMediaState({this.list=const[]});
}
final class SuccessAddMoreMediaState extends ViewEditAddState{
  final List<PickedMedia>list;
  SuccessAddMoreMediaState({this.list=const[]});
}
final class RemoveOneMediaState extends ViewEditAddState{
  final int index;
  RemoveOneMediaState({required this.index});
}
