import 'dart:async';

import 'package:al_hassan_warsha/features/gallery/data/pages_gallery_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_edit_add_event.dart';
part 'view_edit_add_state.dart';

class ViewEditAddBloc extends Bloc<ViewEditAddEvent, ViewEditAddState> {
  PagesGalleryEnum pagesGalleryEnum;
  ViewEditAddBloc({required this.pagesGalleryEnum}) : super(ViewEditAddInitial()) {
    on<ChangeBarIndexEvent>(changeBarIndex);
    on<OpenKitchenForEditEvent>(openOrCloseEdit);
  }
  FutureOr<void> changeBarIndex(
      ChangeBarIndexEvent event, Emitter<ViewEditAddState> emit) {
    emit(ChangeBarIndexState(barIndex: event.currBarIndex));
  }
  FutureOr<void>openOrCloseEdit(OpenKitchenForEditEvent event,Emitter<ViewEditAddState>emit){
    if(event.enableEdit){
      pagesGalleryEnum=PagesGalleryEnum.edit;
    }
    else{
      pagesGalleryEnum=PagesGalleryEnum.view;
    }
    emit(ToggleBetweenEditAndViewState(enableOpen: event.enableEdit));
  }
}
