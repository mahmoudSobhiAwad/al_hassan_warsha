part of 'view_edit_add_bloc.dart';

@immutable
sealed class ViewEditAddEvent {}

final class ChangeBarIndexEvent extends ViewEditAddEvent {
  final int currBarIndex;
  ChangeBarIndexEvent({required this.currBarIndex});
}

final class OpenKitchenForEditEvent extends ViewEditAddEvent {
  final bool enableEdit;
  OpenKitchenForEditEvent({required this.enableEdit});
}

final class AddNewKitchenEvent extends ViewEditAddEvent {
  final String typeId;
  final String name;
  final String? desc;
  final List<PickedMedia>kitchenMediaList;

  AddNewKitchenEvent({required this.typeId, this.desc, required this.name,this.kitchenMediaList=const []});
}

final class EditKitchenEvent extends ViewEditAddEvent {
  final KitchenModel model;
  EditKitchenEvent({required this.model});
}

final class DeleteKitchenEvent extends ViewEditAddEvent {
  final String kitchenId;
  final String typeId;
  DeleteKitchenEvent({required this.kitchenId, required this.typeId});
}
final class RecieveMediaToAddEvent extends ViewEditAddEvent {
  final List<String>medialList;
  RecieveMediaToAddEvent({required this.medialList});
}