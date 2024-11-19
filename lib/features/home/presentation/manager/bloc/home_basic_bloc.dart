import 'dart:async';
import 'dart:io';
import 'package:al_hassan_warsha/core/utils/functions/create_custom_folder.dart';
import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

part 'home_basic_event.dart';
part 'home_basic_state.dart';

class HomeBasicBloc extends Bloc<HomeBasicEvent, HomeBasicState> {
  int currIndex = -1;
  HomeBasicBloc() : super(HomeBasicInitialState()) {
    on<ChangeCurrentPageEvent>(changePage);
    on<CheckDbExistEvent>(checkExistDB);
    on<NavToPageEvent>(navToPage);
    on<CreateNewDBEvent>(createNewDataBase);
  }

  FutureOr<void> changePage(
      ChangeCurrentPageEvent event, Emitter<HomeBasicState> emit) async {
    currIndex = event.currIndex;

    emit(ToggleBetweenPagesState(currIndex: currIndex));
  }

  FutureOr<void> checkExistDB(
      CheckDbExistEvent event, Emitter<HomeBasicState> emit) async {
    final directory = await getApplicationDocumentsDirectory();

    String dbPath = join(directory.path, dbFolder, dbName);

    final exists = await File(dbPath).exists();
    if (exists) {
      await setUp();

      emit(FoundDbState());
    } else {
      emit(NotFoundDbState());
    }
  }

  FutureOr<void> navToPage(
      NavToPageEvent event, Emitter<HomeBasicState> emit) async {
    currIndex = event.currIndex;

    emit(NavToPageState(currIndex: currIndex));
  }

  FutureOr<void> createNewDataBase(
      CreateNewDBEvent event, Emitter<HomeBasicState> emit) async {
    var databaseFactory = databaseFactoryFfi;
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDocumentsDir.path, dbFolder, dbName);
    String imagePaths = join(appDocumentsDir.path, imageFolder);
    String videoPaths = join(appDocumentsDir.path, videoFolder);
    createFolder(imagePaths);
    createFolder(videoPaths);
    try {
      await databaseFactory.openDatabase(
        dbPath,
      );
      await setUp();
      emit(CreateDataBaseSuccessState());
    } catch (e) {
      emit(CreateDataBaseFailedState(errMessage: e.toString()));
    }
  }
}


