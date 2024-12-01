part of 'home_basic_bloc.dart';

@immutable
sealed class HomeBasicState {}

final class HomeBasicInitialState extends HomeBasicState {}

final class ToggleBetweenPagesState extends HomeBasicState {
  final int currIndex;
  ToggleBetweenPagesState({required this.currIndex});
}

final class FoundDbState extends HomeBasicState {}

final class SuccessPickTempPathState extends HomeBasicState {}

final class ShowConfirmationDialog extends HomeBasicState {}

final class ShowExportDialog extends HomeBasicState {}

final class NotFoundDbState extends HomeBasicState {}

final class NavToPageState extends HomeBasicState {
  final int currIndex;
  NavToPageState({required this.currIndex});
}

final class CreateDataBaseSuccessState extends HomeBasicState {}

final class CreateDataBaseLoadingState extends HomeBasicState {}

final class CreateDataBaseFailedState extends HomeBasicState {
  final String? errMessage;
  CreateDataBaseFailedState({this.errMessage});
}

final class ExportDataBaseSuccessState extends HomeBasicState {}

final class ExportDataBaseLoadingState extends HomeBasicState {}

final class ExportDataBaseFailedState extends HomeBasicState {
  final String? errMessage;
  ExportDataBaseFailedState({this.errMessage});
}
