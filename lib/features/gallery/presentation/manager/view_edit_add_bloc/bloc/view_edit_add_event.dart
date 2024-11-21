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
  final List<PickedMedia> kitchenMediaList;

  AddNewKitchenEvent(
      {required this.typeId,
      this.desc,
      required this.name,
      this.kitchenMediaList = const []});
}

final class EditKitchenEvent extends ViewEditAddEvent {
  final KitchenModel model;
  final List<PickedMedia> pickedMediaList;
  final List<String> deletedItems;
  final List<String> addedItems;

  EditKitchenEvent(
      {required this.model,
      this.pickedMediaList = const [],
     required this.deletedItems,
     required this.addedItems});
}

final class DeleteKitchenEvent extends ViewEditAddEvent {
  final String kitchenId;
  final String typeId;
  DeleteKitchenEvent({required this.kitchenId, required this.typeId});
}

final class RecieveMediaToAddEvent extends ViewEditAddEvent {
  final List<String> medialList;
  final bool isMore;
  RecieveMediaToAddEvent({required this.medialList, this.isMore = false});
}
final class RecieveMediaToAddMoreInEditEvent extends ViewEditAddEvent {
  final List<String> medialList;
  
  RecieveMediaToAddMoreInEditEvent({required this.medialList,});
}

final class RemovePickedMediaIndexEvent extends ViewEditAddEvent {
  final int index;
  RemovePickedMediaIndexEvent({required this.index});
}

final class ShowMoreHorizontalMedia extends ViewEditAddEvent {
  final int offset;
  final String kitchenId;
  ShowMoreHorizontalMedia({required this.offset,required this.kitchenId});

}