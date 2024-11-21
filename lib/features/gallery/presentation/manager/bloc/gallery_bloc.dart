import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
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

    on<FetchMoreTypesEvent>(fetchMoreTypes);
    on<ChangePageIndexInShowMoreEvent>(changeCurrentPageOfPaginationInShowMore);
  }
  int showingIndex = -1;
  bool enableMoreWidget = false;
  int currPageInShowMore = 1;
  bool isLoading = true;
  bool isLoadingtypes = true;
  bool isMoredLoading = true;
  bool loadNewest = true;
  List<KitchenTypeModel> basickitchenTypesList = [];
  List<KitchenModel> newestKitchenTypeList = [];
  List<OnlyTypeModel> onlyTypeModelList = [];
  KitchenTypeModel currentShowMoreModel = KitchenTypeModel(
    typeId: "",
    typeName: "",
  );
  bool showMoreIndicator = false;
  bool hasMore = true;
  bool isMoreWidgetLoading = true;

  FutureOr<void> showMoreKitchen(
      ShowMoreKitcenTypeEvent event, Emitter<GalleryState> emit) async {
    enableMoreWidget = event.isOpen;
    currPageInShowMore = 1;
    if (enableMoreWidget) {
      showingIndex = event.currIndex;
      emit(LoadingCreateOrGetData());
      final result = await galleryRepoImp.getChangedTypeModel(
          typeId: event.typeId, limit: 10);
      result.fold((kitchenModel) {
        isMoreWidgetLoading = false;
        currentShowMoreModel = kitchenModel;
        emit(ShowMoreOfKitchenTypeState());
      }, (error) {
        throw (error);
      });
    } else {
      enableMoreWidget = false;
      showingIndex = -1;

      emit(ShowMoreOfKitchenTypeState());
    }
  }

  Future<void> loadAllTypes(Emitter<GalleryState> emit) async {
    emit(LoadingCreateOrGetData());
    final typesList = await galleryRepoImp.loadOnlyTypeList();
    typesList.fold((list) {
      isLoadingtypes = false;
      onlyTypeModelList.addAll(list);
      emit(SuccessCreateOrGetData());
    }, (error) {
      isLoadingtypes = false;
    });
  }

  Future<void> loadLastAdded(Emitter<GalleryState> emit) async {
    emit(LoadingCreateOrGetData());
    final lastAdded = await galleryRepoImp.loadLastAdded();
    lastAdded.fold((list) {
      loadNewest = false;
      newestKitchenTypeList.addAll(list);
      emit(SuccessCreateOrGetData());
    }, (error) {
      loadNewest = false;
      emit(FailureCreateOrGetData());
    });
  }

  Future<void> getAllKitchenTypes(Emitter<GalleryState> emit) async {
    var data = await galleryRepoImp.getAllKitchenTypes();
    return data.fold((list) {
      isLoading = false;
      basickitchenTypesList.addAll(list);
      emit(SuccessCreateOrGetData());
    }, (error) {
      isLoading = false;
      emit(FailureCreateOrGetData(
        errMessage: error,
      ));
    });
  }

  FutureOr<void> checkExistOfGalleryData(
      CheckExistOfGalleryDataEvent event, Emitter<GalleryState> emit) async {
    bool result = await galleryRepoImp.checkDbExistOfGalleryTables(
        tableName: kitchenTypesTableName);
    if (result) {
      await loadAllTypes(emit);
      await loadLastAdded(emit);
      await getAllKitchenTypes(emit);
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

  FutureOr<void> fetchMoreTypes(
      FetchMoreTypesEvent event, Emitter<GalleryState> emit) async {
    emit(LoadingFetchMoreKitchenState());

    final result = await galleryRepoImp.getAllKitchenTypes(
        offset: basickitchenTypesList.length);
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

  FutureOr<void> changeCurrentPageOfPaginationInShowMore(
      ChangePageIndexInShowMoreEvent event, Emitter<GalleryState> emit) async {
    if (event.index != currPageInShowMore) {
      currPageInShowMore = event.index;
      emit(ChangeCurrentPageState());
      await loadMoreKitchenList(emit, offset: currPageInShowMore - 1);
    }
  }

  Future<void> loadMoreKitchenList(Emitter<GalleryState> emit,
      {required int offset}) async {
    emit(LoadingCreateOrGetData());
    isMoredLoading = true;
    final result = await galleryRepoImp.getChangedTypeModel(
        typeId: currentShowMoreModel.typeId,
        offset: offset * currentShowMoreModel.kitchenList.length,
        limit: 10);
    result.fold((newModel) {
      currentShowMoreModel.kitchenList = newModel.kitchenList;
      isMoredLoading = false;
      emit(SuccessCreateOrGetData());
    }, (error) {
      isMoredLoading = false;
      emit(FailureCreateOrGetData(errMessage: error.toString()));
    });
  }
}
