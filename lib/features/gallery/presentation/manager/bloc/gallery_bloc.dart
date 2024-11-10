import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial()) {
    on<ShowMoreKitcenTypeEvent>(showMoreKitchen);
  }
  FutureOr<void>showMoreKitchen(ShowMoreKitcenTypeEvent event,Emitter<GalleryState>emit) async {
    bool showMore=event.showMore;
    emit(ShowMoreOfKitchenTypeState(showMore: showMore));
  }

}
