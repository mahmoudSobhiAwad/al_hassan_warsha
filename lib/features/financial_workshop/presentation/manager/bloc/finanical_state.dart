part of 'finanical_bloc.dart';

@immutable
sealed class FinanicalState {}

final class FinanicalInitialState extends FinanicalState {}

final class ChangeIndexState extends FinanicalState {}

final class ChangeCurrentPageState extends FinanicalState {}

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
