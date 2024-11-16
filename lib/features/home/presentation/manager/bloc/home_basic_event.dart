part of 'home_basic_bloc.dart';

@immutable
sealed class HomeBasicEvent {}
class ChangeCurrentPageEvent extends HomeBasicEvent {
  final int currIndex;
  ChangeCurrentPageEvent({required this.currIndex});
}
final class NavToPageEvent extends HomeBasicEvent{
  final int currIndex;
  NavToPageEvent({required this.currIndex});
}
final class CheckDbExistEvent extends HomeBasicEvent {}

final class CreateNewDBEvent extends HomeBasicEvent {}