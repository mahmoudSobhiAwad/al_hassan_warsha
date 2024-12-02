import 'dart:async';

import 'package:al_hassan_warsha/core/utils/functions/get_media_type.dart';
import 'package:al_hassan_warsha/core/utils/functions/temp_crud_operation.dart';
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
    on<RemovePickedMediaIndexEvent>(removePickedMediaIndex);
    on<RecieveMediaToAddEvent>(addMediaList);
    on<RecieveMediaToAddMoreInEditEvent>(addMediaListInEdit);
    on<ShowMoreHorizontalMedia>(showMoreHorizontalMedia);
  }
  @override
  Future<void> close() async {
    await TempCrudOperation.closeDb();
    return super.close(); // Ensure the parent close method is called
  }

  bool isLoadingEnabled = true;
  bool isLoding = false;

  FutureOr<void> changeBarIndex(
      ChangeBarIndexEvent event, Emitter<ViewEditAddState> emit) {
    emit(ChangeBarIndexState(barIndex: event.currBarIndex));
  }

  FutureOr<void> openOrCloseEdit(
      OpenKitchenForEditEvent event, Emitter<ViewEditAddState> emit) {
    isLoadingEnabled = true;
    if (event.enableEdit) {
      pagesGalleryEnum = PagesGalleryEnum.edit;
    } else {
      pagesGalleryEnum = PagesGalleryEnum.view;
    }
    emit(ToggleBetweenEditAndViewState(enableOpen: event.enableEdit));
  }

  FutureOr<void> addNewKitchen(
      AddNewKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    if (!isLoding) {
      isLoding = true;
      emit(LoadingAddNewKitchenState());
      var kitchenId = const Uuid().v1();
      bool mediaCheck = await addEditKitchenRepoImpl.addMediaInDataBase(
          mediaPickedList: event.kitchenMediaList, kitchenID: kitchenId);
      if (mediaCheck) {
        final result = await addEditKitchenRepoImpl.addNewKitchen(
            model: KitchenModel(
                mediaCounter: event.kitchenMediaList.length,
                kitchenId: kitchenId,
                typeId: event.typeId,
                kitchenDesc: event.desc,
                kitchenName: event.name,
                addedDate: DateTime.now()));
        return result.fold((success) {
          isLoding = false;
          emit(SuccessAddNewKitchenState(model: success));
        }, (error) {
          isLoding = false;
          emit(FailureAddNewKitchenState(errMessage: error.toString()));
        });
      } else {
        emit(FailureAddNewKitchenState(
            errMessage: "some problem in adding media"));
      }
    }
  }

  FutureOr<void> deleteKitchen(
      DeleteKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    if (!isLoding) {
      isLoding = true;
      emit(LoadingDeleteNewKitchenState());
      final result = await addEditKitchenRepoImpl.deleteKitchen(
          mediaPath: event.mediaPath,
          kitchenId: event.kitchenId,
          typeId: event.typeId);
      return result.fold((success) {
        isLoding = false;
        emit(SuccessDeleteNewKitchenState(typeId: success));
      }, (error) {
        isLoding = false;
        emit(FailureDeleteNewKitchenState(errMessage: error.toString()));
      });
    }
  }

  FutureOr<void> editKitchen(
      EditKitchenEvent event, Emitter<ViewEditAddState> emit) async {
    if (!isLoding) {
      isLoding = true;
      emit(LoadingEditKitchenState());
      bool deletedSuccess = true;
      bool addedSuccess = true;
      if (event.deletedItems.isNotEmpty) {
        deletedSuccess =
            await addEditKitchenRepoImpl.removeMediaWithId(event.deletedItems);
      }
      if (event.addedItems.isNotEmpty) {
        addedSuccess = await checkAddNewMedia(event, addedSuccess);
      }
      if (addedSuccess && deletedSuccess) {
        final result =
            await addEditKitchenRepoImpl.updateKitchen(model: event.model);
        return result.fold((success) {
          isLoding = false;
          emit(SuccessEditKitchenState(typeId: success));
        }, (error) {
          isLoding = false;
          emit(FailureEditKitchenState(errMessage: error.toString()));
        });
      } else {
        isLoding = false;
        emit(FailureEditKitchenState(
            errMessage: "some problem while edit media"));
      }
    }
  }

  Future<bool> checkAddNewMedia(
      EditKitchenEvent event, bool addedSuccess) async {
    List<PickedMedia> list = [];
    for (var item in event.addedItems) {
      var mediaId = const Uuid().v4();
      list.add(PickedMedia(
          mediaPath: item, mediaType: getMediaType(item), mediId: mediaId));
      addedSuccess = await addEditKitchenRepoImpl.addMediaInDataBase(
          mediaPickedList: list, kitchenID: event.model.kitchenId);
    }
    return addedSuccess;
  }

  FutureOr<void> addMediaListInEdit(RecieveMediaToAddMoreInEditEvent event,
      Emitter<ViewEditAddState> emit) async {
    List<PickedMedia> list = [];
    for (var item in event.medialList) {
      list.add(PickedMedia(
          mediaPath: item,
          mediaType: getMediaType(item),
          mediId: const Uuid().v1()));
    }
    emit(SuccessAddMoreMediaState(list: list));
  }

  FutureOr<void> addMediaList(
      RecieveMediaToAddEvent event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingAddMediaState());
    try {
      List<PickedMedia> list = [];
      for (var item in event.medialList) {
        list.add(PickedMedia(
            mediaPath: item,
            mediaType: getMediaType(item),
            mediId: const Uuid().v4()));
      }
      if (event.isMore) {
        emit(SuccessAddMoreMediaState(list: list));
      } else {
        emit(SuccessAddMediaState(list: list));
      }
    } catch (e) {
      emit(FailureAddMediaState(errMessage: e.toString()));
    }
  }

  FutureOr<void> removePickedMediaIndex(
      RemovePickedMediaIndexEvent event, Emitter<ViewEditAddState> emit) async {
    emit(RemoveOneMediaState(index: event.index));
  }

  FutureOr<void> showMoreHorizontalMedia(
      ShowMoreHorizontalMedia event, Emitter<ViewEditAddState> emit) async {
    emit(LoadingFetchMoreMediaListState());
    final result = await addEditKitchenRepoImpl.loadMoreMedia(
        kitchenId: event.kitchenId, offset: event.offset);

    return result.fold((mediaList) {
      if (mediaList.isNotEmpty) {
        emit(SuccessFetchMoreMediaListState(list: mediaList));
      }
      isLoadingEnabled = false;
    }, (error) {});
  }
}
