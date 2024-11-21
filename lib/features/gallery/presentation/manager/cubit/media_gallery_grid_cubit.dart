import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/fetch_media_gallery/fetch_medi.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'media_gallery_grid_state.dart';

class MediaGalleryGridCubit extends Cubit<MediaGalleryGridState> {
  final String kitchenId;
  final FetchMediaRepoImpl fetchMediaRepoImpl;

  MediaGalleryGridCubit(
      {required this.kitchenId, required this.fetchMediaRepoImpl})
      : super(MediaGalleryGridInitial());
  List<PickedMedia> pickedList = [];
  bool isLoading = true;
  ScrollController controller = ScrollController();
  bool enableLoadMore = true;
  bool isLoadingMore=false;
  Future<void> fetchMore() async {
    if (enableLoadMore) {
      isLoadingMore=true;
      emit(LoadingGalleryGridState());
      final result = await fetchMediaRepoImpl.fetchMoreMedi(
          kitchenId: kitchenId, offset: pickedList.length);
      return result.fold((mediaList) {
        isLoadingMore=false;
        if (mediaList.length < 8) {
          enableLoadMore = false;
        }
        for (var item in mediaList) {
          pickedList.add(item);
        }
        
        emit(SuccessGalleryGridState());
      }, (error) {
        isLoadingMore=true;
        emit(FailureGalleryGridState(errMessage: error));
      });
    }
  }

  Future<void> fetchForFirstTime() async {
    emit(LoadingGalleryGridState());
    final result =
        await fetchMediaRepoImpl.fetchMoreMedi(kitchenId: kitchenId, offset: 0);
    return result.fold((mediaList) {
      if (mediaList.isEmpty || mediaList.length < 9) {
        enableLoadMore = false;
      }
      isLoading = false;
      
      pickedList.addAll(mediaList);
      emit(SuccessGalleryGridState());
    }, (error) {
      isLoading = false;
      emit(FailureGalleryGridState(errMessage: error));
    });
    
  }

  Future<void> addListener() async {
    controller.addListener(() async {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          enableLoadMore) {
        await fetchMore();
      }
    });
  }
}
