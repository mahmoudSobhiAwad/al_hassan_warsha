part of 'home_basic_bloc.dart';

@immutable
sealed class HomeBasicState {}

final class HomeBasicInitialState extends HomeBasicState {}

final class ToggleBetweenPagesState extends HomeBasicState {
  final int currIndex;
   ToggleBetweenPagesState({required this.currIndex});
}
