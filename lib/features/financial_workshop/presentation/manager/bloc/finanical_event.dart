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
  ChangeSearchModelEvent({required this.model});
}
final class ChangeSearchKeyWordEvent extends FinanicalEvent {
  final String text;
  ChangeSearchKeyWordEvent({required this.text});
}
