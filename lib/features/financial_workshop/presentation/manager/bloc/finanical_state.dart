part of 'finanical_bloc.dart';

@immutable
sealed class FinanicalState {}

final class FinanicalInitialState extends FinanicalState {}

final class ChangeIndexState extends FinanicalState {}

final class ChangeCurrentPageState extends FinanicalState {}

final class ChangeSearchMoodState extends FinanicalState {}

final class LoadingFetchOrderState extends FinanicalState {}

final class SuccessFetchOrderState extends FinanicalState {}

final class FailureFetchOrderState extends FinanicalState {
  final String? errMessage;
  FailureFetchOrderState({required this.errMessage});
}

final class LoadingUpdateCounterOrderState extends FinanicalState {}

final class SuccessUpdateCounterOrderState extends FinanicalState {}

final class FailureUpdateCounterOrderState extends FinanicalState {
  final String? errMessage;
  FailureUpdateCounterOrderState({required this.errMessage});
}

final class ChangeSearchModelState extends FinanicalState {}

/// states related to transaction .
final class ChangeTransactionWayState extends FinanicalState {}

final class ChangeTransactionMethodState extends FinanicalState {}

final class ChangeTransactionHistoryState extends FinanicalState {}

final class LoadingAddTransactionState extends FinanicalState {}

final class SuccessAddTransactionState extends FinanicalState {}

final class FailureAddTransactionState extends FinanicalState {
  final String? errMessage;
  FailureAddTransactionState({this.errMessage});
}

final class LoadingGetAllTransactionState extends FinanicalState {}

final class SuccessGetAllTransactionState extends FinanicalState {}

final class FailureGetAllTransactionState extends FinanicalState {
  final String? errMessage;
  FailureGetAllTransactionState({this.errMessage});
}
final class ChangeCurrMonthState extends FinanicalState {}

final class ChangeCurYearState extends FinanicalState {}