import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/gallery_repo_imp.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepoImp galleryRepoImp;
  GalleryBloc({required this.galleryRepoImp}) : super(GalleryInitial()) {
    on<ShowMoreKitcenTypeEvent>(showMoreKitchen);
    on<CheckExistOfGalleryDataEvent>(checkExistOfGalleryData);
    on<AddNewKitchenTypeEvent>(addNewKitchenType);
    on<FetchKitchenTypeAfterChangeEvent>(fetchKitchenTypeAfterChange);
    on<UpdateCatchDataEvent>(updateCatching);
    on<FetchMoreTypesEvent>(fetchMoreTypes);
  }
  int showingIndex = -1;
  bool enableMoreWidget = false;
  bool isLoading = true;
  List<KitchenTypeModel> basickitchenTypesList = [];
  List<OnlyTypeModel> onlyTypeModelList = [];
  KitchenTypeModel currentShowMoreModek=KitchenTypeModel(typeId: "", typeName: "",);
  bool showMoreIndicator = false;
  bool hasMore = true;
  bool isMoreWidgetLoading = true;

  FutureOr<void> showMoreKitchen(
      ShowMoreKitcenTypeEvent event, Emitter<GalleryState> emit) async {
    enableMoreWidget = event.isOpen;

    if (enableMoreWidget) {
      showingIndex = event.currIndex;
      emit(LoadingCreateOrGetData());
      final result = await galleryRepoImp.getChangedTypeModel(
          typeId: event.typeId, limit: 10);
      result.fold((kitchenModel) {
        isMoreWidgetLoading = false;
        currentShowMoreModek=kitchenModel;
        emit(ShowMoreOfKitchenTypeState());
      }, (error) {
        throw (error);
      });
    } else {
      enableMoreWidget = false;
      emit(ShowMoreOfKitchenTypeState());
    }
  }

  FutureOr<void> checkExistOfGalleryData(
      CheckExistOfGalleryDataEvent event, Emitter<GalleryState> emit) async {
    bool result = await galleryRepoImp.checkDbExistOfGalleryTables(
        tableName: kitchenTypesTableName);
    if (result) {
      emit(LoadingCreateOrGetData());
      final typesList = await galleryRepoImp.loadOnlyTypeList();
      typesList.fold((list) {
        onlyTypeModelList.addAll(list);
      }, (error) {});
      var result = await galleryRepoImp.getAllKitchenTypes();
      return result.fold((list) {
        isLoading = false;
        basickitchenTypesList.addAll(list);
        emit(SuccessCreateOrGetData());
      }, (error) {
        isLoading = false;
        emit(FailureCreateOrGetData(
          errMessage: error,
        ));
      });
    } else {
      emit(LoadingCreateOrGetData());
      try {
        await galleryRepoImp.createDataTablesForGallery();
        emit(SuccessCreateOrGetData());
      } catch (e) {
        emit(FailureCreateOrGetData(errMessage: e.toString()));
      }
    }
  }

  FutureOr<void> addNewKitchenType(
      AddNewKitchenTypeEvent event, Emitter<GalleryState> emit) async {
    emit(LoadingAddedNewKitchenType());
    var v1 = const Uuid().v1();
    var result = await galleryRepoImp.addNewKitchenType(
        model: KitchenTypeModel(typeId: v1, typeName: event.typeName));
    return result.fold((success) {
      basickitchenTypesList
          .add(KitchenTypeModel(typeId: v1, typeName: event.typeName));
      emit(SuccessAddedNewKitchenType());
    }, (error) {
      emit(FailureAddedNewKitchenType(errMessage: error.toString()));
    });
  }

  FutureOr<void> fetchKitchenTypeAfterChange(
      FetchKitchenTypeAfterChangeEvent event,
      Emitter<GalleryState> emit) async {
    final result =
        await galleryRepoImp.getChangedTypeModel(typeId: event.typeId);
    result.fold((kitchenList) {
      int changedIndex = basickitchenTypesList
          .indexWhere((model) => model.typeId == event.typeId);
      basickitchenTypesList[changedIndex] = kitchenList;
      emit(FetchKitchenTypeAfterChangeState());
    }, (error) {
      throw error;
    });
  }

  FutureOr<void> updateCatching(
      UpdateCatchDataEvent event, Emitter<GalleryState> emit) async {
    showingIndex = -1;
    emit(SuccessCreateOrGetData());
  }

  FutureOr<void> fetchMoreTypes(
      FetchMoreTypesEvent event, Emitter<GalleryState> emit) async {
    emit(LoadingFetchMoreKitchenState());
    
    final result =
        await galleryRepoImp.getAllKitchenTypes(offset: basickitchenTypesList.length);
    return result.fold((kitchenList) {
      if (kitchenList.isNotEmpty) {
        for (var item in kitchenList) {
          basickitchenTypesList.add(item);
          showMoreIndicator = false;
          emit(SuccessFetchMoreKitchenState());
        }
      } else {
        hasMore = false;
        showMoreIndicator = false;
        emit(SuccessFetchMoreKitchenState());
      }
    }, (error) {
      showMoreIndicator = false;
      emit(FailureAddedNewKitchenType(errMessage: error));
    });
  }
}
