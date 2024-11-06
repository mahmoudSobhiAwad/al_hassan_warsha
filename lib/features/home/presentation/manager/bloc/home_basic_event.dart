part of 'home_basic_bloc.dart';

@immutable
sealed class HomeBasicEvent {}
class ChangeCurrentPageEvent extends HomeBasicEvent {
  final int currIndex;
  ChangeCurrentPageEvent({required this.currIndex});
}