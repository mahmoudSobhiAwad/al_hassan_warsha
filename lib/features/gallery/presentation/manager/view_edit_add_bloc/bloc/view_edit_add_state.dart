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
