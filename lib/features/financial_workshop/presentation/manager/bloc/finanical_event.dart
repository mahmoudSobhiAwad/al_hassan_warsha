part of 'finanical_bloc.dart';

@immutable
sealed class FinanicalEvent {}

final class FetchAllOrderWithThierBillEvent extends FinanicalEvent {
  final int offset;
  final int farzIndex;
  FetchAllOrderWithThierBillEvent({this.offset = 0,this.farzIndex=-1});
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
  final bool isFarz;
  ChangeSearchModelEvent({required this.model,this.isFarz=false});
}
final class ChangeSearchKeyWordEvent extends FinanicalEvent {
  final String text;
  ChangeSearchKeyWordEvent({required this.text});
}
