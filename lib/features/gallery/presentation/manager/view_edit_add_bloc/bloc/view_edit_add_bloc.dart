import 'dart:async';

import 'package:al_hassan_warsha/core/utils/functions/get_media_type.dart';
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
    on<EditKitchenEvent>(editKitchen);
    on<RecieveMediaToAddEvent>(addMediaList);
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
    var kitchenId = const Uuid().v1();
    bool mediaCheck = await addEditKitchenRepoImpl.addMediaInDataBase(
        mediaPickedList: event.kitchenMediaList, kitchenID: kitchenId);
    if (mediaCheck) {
      final result = await addEditKitchenRepoImpl.addNewKitchen(
          model: KitchenModel(
              kitchenId: kitchenId,
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
    else {
      emit(FailureAddNewKitchenState(
          errMessage: "some problem in adding media"));
    }
  }

  FutureOr<void> deleteKitchen(
      DeleteKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingDeleteNewKitchenState());
    final result = await addEditKitchenRepoImpl.deleteKitchen(
        kitchenId: event.kitchenId, typeId: event.typeId);
    return result.fold((success) {
      emit(SuccessDeleteNewKitchenState(typeId: success));
    }, (error) {
      emit(FailureDeleteNewKitchenState(errMessage: error.toString()));
    });
  }

  FutureOr<void> editKitchen(
      EditKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingEditKitchenState());
    final result =
        await addEditKitchenRepoImpl.updateKitchen(model: event.model);
    return result.fold((success) {
      emit(SuccessEditKitchenState(typeId: success));
    }, (error) {
      emit(FailureEditKitchenState(errMessage: error.toString()));
    });
  }

  FutureOr<void> addMediaList(
      RecieveMediaToAddEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingAddMediaState());
    try {
      List<PickedMedia> list = [];
      for (var item in event.medialList) {
        list.add(PickedMedia(mediaPath: item, mediaType: getMediaType(item),mediId:const Uuid().v4()));
      }
      emit(SuccessAddMediaState(list: list));
    } catch (e) {
      emit(FailureAddMediaState(errMessage: e.toString()));
    }
  }
}
