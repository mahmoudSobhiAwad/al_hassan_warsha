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

final class LoadingDeleteTransactionState extends FinanicalState {}

final class SuccessDeleteTransactionState extends FinanicalState {}

final class FailureDeleteTransactionState extends FinanicalState {
  final String? errMessage;
  FailureDeleteTransactionState({this.errMessage});
}

final class ChangeCurrMonthState extends FinanicalState {}

final class ChangeCurYearState extends FinanicalState {}

final class ChangeSelectedWorkersState extends FinanicalState {}

final class AddNewWorkerInUiState extends FinanicalState {}

final class ChangeSalaryTypeState extends FinanicalState {}

final class ChangeEnableEditState extends FinanicalState {}

final class LoadingFetchAllWorkersDateState extends FinanicalState {}

final class SuccessFetchAllWorkersDateState extends FinanicalState {}

final class FailureFetchAllWorkersDateState extends FinanicalState {
  final String? errMessage;
  FailureFetchAllWorkersDateState({this.errMessage});
}

final class PrepareBeforeEditOrAddWorkerState extends FinanicalState {}
final class LoadingRemoveWorkersData extends FinanicalState {}

final class SuccessRemoveWorkersData extends FinanicalState {}

final class FailureRemoveWorkersData extends FinanicalState {
  final String? errMessage;
  FailureRemoveWorkersData({this.errMessage});
}

final class LoadingEditWorkersData extends FinanicalState {}

final class SuccessEditWorkersData extends FinanicalState {}

final class FailureEditWorkersData extends FinanicalState {
  final String? errMessage;
  FailureEditWorkersData({this.errMessage});
}

final class LoadingPayAllSalariesWorkersState extends FinanicalState {}

final class SuccessPayAllSalariesWorkersState extends FinanicalState {}

final class FailurePayAllSalariesWorkersState extends FinanicalState {
  final String? errMessage;
  FailurePayAllSalariesWorkersState({this.errMessage});
}

final class ChanegeStartOrEndDateState extends FinanicalState {}

final class LoadingAnalysisState extends FinanicalState {}

final class SuccessAnalysisState extends FinanicalState {}

final class FailureAnalysisState extends FinanicalState {
  final String? errMessage;
  FailureAnalysisState({this.errMessage});
}

final class NavToAnlysisListState extends FinanicalState {
  final String type;
  final int typedIndex;
  NavToAnlysisListState({required this.type,required this.typedIndex});
}

final class ChangeCurrPageState extends FinanicalState {}

final class ChangeSideBarActiveState extends FinanicalState {}

final class LoadingGetAnalysisListState extends FinanicalState {}

final class SuccessGetAnalysisListState extends FinanicalState {}

final class FailureGetAnalysisListState extends FinanicalState {
  final String? errMessage;
  FailureGetAnalysisListState({this.errMessage});
}
