import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_basic_event.dart';
part 'home_basic_state.dart';

class HomeBasicBloc extends Bloc<HomeBasicEvent, HomeBasicState> {
  HomeBasicBloc() : super(HomeBasicInitialState()) {
    on<ChangeCurrentPageEvent>(changePage);
  }
  FutureOr<void>changePage(ChangeCurrentPageEvent event,Emitter<HomeBasicState>emit) async {
    int currIndex=event.currIndex;
    emit(ToggleBetweenPagesState(currIndex: currIndex));
  }
}
