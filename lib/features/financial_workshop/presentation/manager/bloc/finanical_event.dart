part of 'finanical_bloc.dart';

@immutable
sealed class FinanicalEvent {}

final class FetchAllOrderWithThierBillEvent extends FinanicalEvent {
  final int offset;
  final int farzIndex;
  FetchAllOrderWithThierBillEvent({this.offset = 0, this.farzIndex = -1});
}

final class DownStepCounterEvent extends FinanicalEvent {
  final String pillId;
  final String totalPayedAmount;
  final String payedAmount;
  DownStepCounterEvent({
    required this.pillId,
    required this.totalPayedAmount,
    required this.payedAmount,
  });
}

final class ChangeCurrentIndexEvent extends FinanicalEvent {
  final int index;
  ChangeCurrentIndexEvent({required this.index});
}

final class ChangePageInFetchOrderEvent extends FinanicalEvent {
  final int index;
  ChangePageInFetchOrderEvent({required this.index});
}

final class EnableOrDisableSearchEvent extends FinanicalEvent {
  final bool status;
  EnableOrDisableSearchEvent({required this.status});
}

final class SearchForOrderDataEvent extends FinanicalEvent {
  final String status;
  SearchForOrderDataEvent({required this.status});
}

final class ChangeSearchModelEvent extends FinanicalEvent {
  final SearchModel model;
  final bool isFarz;
  ChangeSearchModelEvent({required this.model, this.isFarz = false});
}

final class ChangeSearchKeyWordEvent extends FinanicalEvent {
  final String text;
  ChangeSearchKeyWordEvent({required this.text});
}

/// events related to transactions
final class GetAllTransactionEvent extends FinanicalEvent {}

final class ChangePaymentTypeEvent extends FinanicalEvent {
  final TransactionType type;
  ChangePaymentTypeEvent({required this.type});
}

final class ChangeAllTransactionTypesEvent extends FinanicalEvent {
  final AllTransactionTypes type;
  ChangeAllTransactionTypesEvent({required this.type});
}

final class ChangeHistoryOfTransactionEvent extends FinanicalEvent {
  final DateTime time;
  ChangeHistoryOfTransactionEvent({required this.time});
}

final class ChangeTransactionMethodEvent extends FinanicalEvent {
  final TransactionMethod method;
  ChangeTransactionMethodEvent({required this.method});
}

final class AddNewTransactionEvent extends FinanicalEvent {}

final class ChangeCurrentMonthEvent extends FinanicalEvent {
  final int currentMonth;
  ChangeCurrentMonthEvent({required this.currentMonth});
}

final class ChangeCurrentYearEvent extends FinanicalEvent {
  final int year;
  ChangeCurrentYearEvent({required this.year});
}

final class DeleteTransactionEvent extends FinanicalEvent {
  final String transactionId;
  DeleteTransactionEvent({required this.transactionId});
}

final class SelectWorkerEvent extends FinanicalEvent {
  final int index;
  final bool isSelectAll;
  SelectWorkerEvent({required this.index, required this.isSelectAll});
}

final class GetAllWorkersDataEvent extends FinanicalEvent {}

final class AddNewWorkerEvent extends FinanicalEvent {}

final class DeleteWorkerEvent extends FinanicalEvent {
  final int index;
  DeleteWorkerEvent({required this.index});
}

final class EnableEditForWorkersEvent extends FinanicalEvent {
  final bool isEdit;
  EnableEditForWorkersEvent({required this.isEdit});
}

final class SaveChangesAddOrEditEvent extends FinanicalEvent {}

final class ChangeSalaryTypeEvent extends FinanicalEvent {
  final SalaryType type;
  final int index;
  ChangeSalaryTypeEvent({required this.type, required this.index});
}

final class PayAllSalariesEvent extends FinanicalEvent {}

final class ChangeStartOrEndDateEvent extends FinanicalEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  ChangeStartOrEndDateEvent({this.endDate, this.startDate});
}

final class MakeAnalysisEvent extends FinanicalEvent {}

final class NavToAnlysisListEvent extends FinanicalEvent {
  final int index;
  final String type;
  NavToAnlysisListEvent({required this.index, required this.type});
}

final class GetAllAnalysisTransactionListEvent extends FinanicalEvent {
  final int index;
  GetAllAnalysisTransactionListEvent({required this.index});
}

final class ChangeCurrPageEvent extends FinanicalEvent {
  final int pageIndex;
  final int indexType;
  ChangeCurrPageEvent({required this.pageIndex, required this.indexType});
}

final class ChangeSideBarActiveEvent extends FinanicalEvent {
  final bool isActiveState;

  ChangeSideBarActiveEvent({required this.isActiveState});
}
