import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'view_edit_add_event.dart';
part 'view_edit_add_state.dart';

class ViewEditAddBloc extends Bloc<ViewEditAddEvent, ViewEditAddState> {
  PagesGalleryEnum pagesGalleryEnum;
  final AddEditKitchenRepoImpl addEditKitchenRepoImpl;
  ViewEditAddBloc(
      {required this.pagesGalleryEnum, required this.addEditKitchenRepoImpl})
      : super(ViewEditAddInitial()) {
    on<ChangeBarIndexEvent>(changeBarIndex);
    on<OpenKitchenForEditEvent>(openOrCloseEdit);
    on<AddNewKitchenEvent>(addNewKitchen);
    on<DeleteKitchenEvent>(deleteKitchen);
  }
  FutureOr<void> changeBarIndex(
      ChangeBarIndexEvent event, Emitter<ViewEditAddState> emit) {
    emit(ChangeBarIndexState(barIndex: event.currBarIndex));
  }

  FutureOr<void> openOrCloseEdit(
      OpenKitchenForEditEvent event, Emitter<ViewEditAddState> emit) {
    if (event.enableEdit) {
      pagesGalleryEnum = PagesGalleryEnum.edit;
    } else {
      pagesGalleryEnum = PagesGalleryEnum.view;
    }
    emit(ToggleBetweenEditAndViewState(enableOpen: event.enableEdit));
  }

  FutureOr<void> addNewKitchen(
      AddNewKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingAddNewKitchenState());
    final result = await addEditKitchenRepoImpl.addNewKitchen(
        model: KitchenModel(
            kitchenId: const Uuid().v1(),
            typeId: event.typeId,
            kitchenDesc: event.desc,
            kitchenName: event.name,
            addedDate: DateTime.now()));
    return result.fold((success) {
      emit(SuccessAddNewKitchenState(model: success));
    }, (error) {
      emit(FailureAddNewKitchenState(errMessage: error.toString()));
    });
  }
  FutureOr<void> deleteKitchen(
      DeleteKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingDeleteNewKitchenState());
    final result = await addEditKitchenRepoImpl.deleteKitchen(
        kitchenId: event.kitchenId,typeId: event.typeId);
    return result.fold((success) {
      emit(SuccessDeleteNewKitchenState(typeId: success));
    }, (error) {
      emit(FailureDeleteNewKitchenState(errMessage: error.toString()));
    });
  }
}
