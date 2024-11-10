part of 'view_edit_add_bloc.dart';

@immutable
sealed class ViewEditAddEvent {}

final class ChangeBarIndexEvent extends ViewEditAddEvent {
  final int currBarIndex;
  ChangeBarIndexEvent({required this.currBarIndex});
}

final class OpenKitchenForEditEvent extends ViewEditAddEvent {
  final bool enableEdit ;
  OpenKitchenForEditEvent({required this.enableEdit});
}
