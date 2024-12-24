part of 'table_cubit.dart';

@immutable
sealed class TableState {}

final class TableInitialState extends TableState {}

final class ChangeBackGroundColorState extends TableState {}

final class ChangeFontSizeState extends TableState {}

final class CreateOrEditTableState extends TableState {}

final class FailureCreateOrEditTableState extends TableState {
  final String ?errMessage;
  FailureCreateOrEditTableState({this.errMessage});
}

final class UpdateTableRowOrColumnDimensionsState extends TableState {}

final class UpdateTableRowOrColumnState extends TableState {}

final class EnableOrDisableCounterState extends TableState {}

final class ChangeOptionInAddOrDeleteTableElement extends TableState {}

final class ChangeCheckedBoxForAnyState extends TableState {}

