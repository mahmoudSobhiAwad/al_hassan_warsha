part of 'home_basic_bloc.dart';

@immutable
sealed class HomeBasicEvent {}

class ChangeCurrentPageEvent extends HomeBasicEvent {
  final int currIndex;
  ChangeCurrentPageEvent({required this.currIndex});
}
class ChangePageInPhoneLayoutEvent extends HomeBasicEvent {
  final int pageIndex;
  ChangePageInPhoneLayoutEvent({required this.pageIndex});
}

final class NavToPageEvent extends HomeBasicEvent {
  final int currIndex;
  NavToPageEvent({required this.currIndex});
}

final class CheckDbExistEvent extends HomeBasicEvent {}

final class CreateNewDBEvent extends HomeBasicEvent {}

final class ConfirmToCreateTheNewDb extends HomeBasicEvent {}

final class CreatePathForMeidaAndTempDataEvent extends HomeBasicEvent {
  final bool isRestoring;
  CreatePathForMeidaAndTempDataEvent({this.isRestoring=false});
}

final class NaveToExportFromTempEvent extends HomeBasicEvent {}

final class ExportFromTempDataEvent extends HomeBasicEvent {}
