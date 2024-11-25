part of 'finanical_bloc.dart';

@immutable
sealed class FinanicalEvent {}

final class FetchAllOrderWithThierBillEvent extends FinanicalEvent {
  final int offset;
  FetchAllOrderWithThierBillEvent({this.offset = 0});
}

final class DownStepCounterEvent extends FinanicalEvent {
  final String pillId;
  final String remianAmount;
  DownStepCounterEvent({required this.pillId, required this.remianAmount});
}

final class ChangeCurrentIndexEvent extends FinanicalEvent {
  final int index;
  ChangeCurrentIndexEvent({required this.index});
}

final class ChangePageInFetchOrderEvent extends FinanicalEvent {
  final int index;
  ChangePageInFetchOrderEvent({required this.index});
}
