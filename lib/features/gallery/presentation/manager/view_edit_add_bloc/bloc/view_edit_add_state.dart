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

final class SuccessAddNewKitchenState extends ViewEditAddState {}

final class ClearDataAfterAddState extends ViewEditAddState {}
