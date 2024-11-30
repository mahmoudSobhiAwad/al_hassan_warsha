import 'dart:async';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/gallery_repo_imp.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepoImp galleryRepoImp;
  GalleryBloc({required this.galleryRepoImp}) : super(GalleryInitial()) {
    on<ShowMoreKitcenTypeEvent>(showMoreKitchen);
    on<AddNewKitchenTypeEvent>(addNewKitchenType);
    on<FetchKitchenTypeAfterChangeEvent>(fetchKitchenTypeAfterChange);
    on<GetAllGalleryDataEvent>(getAllGalleryData);
    on<FetchMoreTypesEvent>(fetchMoreTypes);
    on<ChangePageIndexInShowMoreEvent>(changeCurrentPageOfPaginationInShowMore);
    on<DefineTimerFunctionEvent>(changeCurrPage);
  }
  int showingIndex = -1;
  bool enableMoreWidget = false;
  int currPageInShowMore = 1;
  bool isLoading = true;
  bool isMoredLoading = true;

  List<KitchenTypeModel> basickitchenTypesList = [];
  List<KitchenModel> newestKitchenTypeList = [];
  List<OnlyTypeModel> onlyTypeModelList = [];
  KitchenTypeModel currentShowMoreModel = KitchenTypeModel(
    typeId: "",
    typeName: "",
  );
  @override
  Future<void> close() async {
    pageController.dispose();
    controller.dispose();

    timer?.cancel();
    await super.close();
  }

  bool showMoreIndicator = false;
  bool hasMore = true;
  bool isMoreWidgetLoading = true;

  PageController pageController = PageController();
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Timer? timer;
  int currentPage = 0;

  FutureOr<void> changeCurrPage(
      DefineTimerFunctionEvent event, Emitter<GalleryState> emit) async {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        currentPage++;

        if (currentPage >= newestKitchenTypeList.length) {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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

  FutureOr<void> getAllGalleryData(
      GetAllGalleryDataEvent event, Emitter<GalleryState> emit) async {
    isLoading = true;
    emit(LoadingCreateOrGetData());
    final result = await galleryRepoImp.getAllGalleryData();
    return result.fold((allData) {
      newestKitchenTypeList = allData.$1;
      basickitchenTypesList = allData.$2;
      onlyTypeModelList = allData.$3;
      isLoading = false;
      emit(SuccessCreateOrGetData());
    }, (error) {
      isLoading = false;
      emit(FailureCreateOrGetData());
    });
  }

  FutureOr<void> addNewKitchenType(
      AddNewKitchenTypeEvent event, Emitter<GalleryState> emit) async {
    emit(LoadingAddedNewKitchenType());
    var v1 = const Uuid().v1();
    var result = await galleryRepoImp.addNewKitchenType(
        model: KitchenTypeModel(typeId: v1, typeName: controller.text));
    return result.fold((success) {
      basickitchenTypesList
          .add(KitchenTypeModel(typeId: v1, typeName: controller.text));
      onlyTypeModelList.add(
          OnlyTypeModel(itemsCount: 0, typeId: v1, typeName: controller.text));
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
