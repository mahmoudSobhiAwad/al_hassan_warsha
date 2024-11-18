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
    on<AddNewKitchenFromGalleryEvent>(addNewKitchen);
    on<ReomveKitchenFromGalleryEvent>(removeKitchen);
    on<UpdateCatchDataEvent>(updateCatching);
  }
  int showingIndex=-1;
  FutureOr<void> showMoreKitchen(
      ShowMoreKitcenTypeEvent event, Emitter<GalleryState> emit) async {
        showingIndex=event.currIndex;
       emit(ShowMoreOfKitchenTypeState(currIndex: event.currIndex));
   
  }

  FutureOr<void> checkExistOfGalleryData(
      CheckExistOfGalleryDataEvent event, Emitter<GalleryState> emit) async {
    bool result = await galleryRepoImp.checkDbExistOfGalleryTables(
        tableName: kitchenTypesTableName);
    if (result) {
      emit(LoadingCreateOrGetData());
      var result = await galleryRepoImp.getAllKitchenTypes();
      return result.fold((list) {
        emit(SuccessCreateOrGetData(kitchenTypesList: list));
      }, (error) {
        emit(FailureCreateOrGetData(
          errMessage: error,
        ));
      });
    } else {
      emit(LoadingCreateOrGetData());
      try {
        await galleryRepoImp.createDataTablesForGallery();
        emit(SuccessCreateOrGetData(kitchenTypesList: const []));
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
      emit(SuccessAddedNewKitchenType(typeId: v1,typeName:event.typeName));
      
    }, (error) {
      emit(FailureAddedNewKitchenType(errMessage: error.toString()));
    });
  }
  FutureOr<void> addNewKitchen(
      AddNewKitchenFromGalleryEvent event, Emitter<GalleryState> emit) async {
        emit(AddNewKitchenState(kitchenModel: event.kitchenModel));
  }
  FutureOr<void> removeKitchen(
      ReomveKitchenFromGalleryEvent event, Emitter<GalleryState> emit) async {
        emit(RemoveKitchenState(kitcehnId: event.kitchenId,typeId: event.typeId));
  }
  FutureOr<void> updateCatching(
      UpdateCatchDataEvent event, Emitter<GalleryState> emit) async {
        showingIndex=-1;
        emit(SuccessCreateOrGetData(kitchenTypesList:event.kitchenList));
  }
}
