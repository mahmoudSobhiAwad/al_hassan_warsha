import 'dart:async';
import 'dart:io';
import 'package:al_hassan_warsha/core/utils/functions/create_custom_folder.dart';
import 'package:al_hassan_warsha/core/utils/functions/save_paths.dart';
import 'package:al_hassan_warsha/core/utils/functions/service_locator.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:al_hassan_warsha/features/home/data/home_repos/home_repo_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'home_basic_event.dart';
part 'home_basic_state.dart';

class HomeBasicBloc extends Bloc<HomeBasicEvent, HomeBasicState> {
  int currIndex = -1;
  HomeBasicBloc() : super(HomeBasicInitialState()) {
    on<ChangeCurrentPageEvent>(changePage);
    on<CheckDbExistEvent>(checkExistDB);
    on<NavToPageEvent>(navToPage);
    on<CreateNewDBEvent>(createNewDataBase);
    on<CreatePathForMeidaAndTempDataEvent>(createTempDataBase);
    on<ConfirmToCreateTheNewDb>(confirmToCreate);
  }
  bool isExist = false;
  bool isLoading = false;
  String? tempPath;
  String? mediaPath;
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
      isExist = true;
      emit(FoundDbState());
    } else {
      emit(NotFoundDbState());
    }
  }

  FutureOr<void> navToPage(
      NavToPageEvent event, Emitter<HomeBasicState> emit) async {
    if (isExist) {
      currIndex = event.currIndex;

      emit(NavToPageState(currIndex: currIndex));
    } else {
      emit(NotFoundDbState());
    }
  }

  FutureOr<void> createTempDataBase(CreatePathForMeidaAndTempDataEvent event,
      Emitter<HomeBasicState> emit) async {
    await FilePicker.platform.getDirectoryPath().then((value) {
      if (value != null) {
        if (event.isMediaPath) {
          mediaPath = value;
        } else {
          tempPath = value;
        }
      }
    });
    emit(SuccessPickTempPathState());
  }

  FutureOr<void> confirmToCreate(
      ConfirmToCreateTheNewDb event, Emitter<HomeBasicState> emit) async {
    isLoading = true;
    emit(CreateDataBaseLoadingState());
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final homeRepoImpl = HomeRepoImpl();
    if (tempPath != null && mediaPath != null) {
      String dbPath = join(appDocumentsDir.path, dbFolder, dbName);
      String dbTempPath = join(tempPath!, tempFolder, dbFolder, dbTempName);
      String imagePaths = join(mediaPath!, mediaBasicFolder, imageFolder);
      String videoPaths = join(mediaPath!, mediaBasicFolder, videoFolder);
      String tempImagePath = join(tempPath!, tempFolder, dbFolder, imageFolder);
      String tempVideoPath = join(tempPath!, tempFolder, dbFolder, videoFolder);
      createFolder(imagePaths);
      createFolder(videoPaths);
      createFolder(tempImagePath);
      createFolder(tempVideoPath);
      await SharedPrefHelper.saveFolderPath({
        imageMainPath: imagePaths,
        videoMainPath: videoPaths,
        imageTempPath: tempImagePath,
        videoTempPath: tempVideoPath,
        tempDataPath: dbTempPath,
      });
      final result = await homeRepoImpl.createTheSchemaForTheWholeDb(dbPath,
          tempDataBase: dbTempPath);
      result.fold((check) {
        isLoading = false;
        emit(CreateDataBaseSuccessState());
        add(CheckDbExistEvent());
      }, (error) {
        isLoading = false;
        emit(CreateDataBaseFailedState(errMessage: error));
      });
    } else {
      isLoading = false;
      emit(CreateDataBaseFailedState(errMessage: "حدد المسار الاحتياطي "));
    }
  }

  FutureOr<void> createNewDataBase(
      CreateNewDBEvent event, Emitter<HomeBasicState> emit) async {
    emit(ShowConfirmationDialog());
  }

  Future<void> createMainDatabase(String dbFolder, String dbName) async {
    // Get the application documents directory
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Construct the full path for the database file
    final String dbFolderPath = join(appDocumentsDir.path, dbFolder);
    final String dbPath = join(dbFolderPath, dbName);

    // Ensure the folder exists
    final Directory folder = Directory(dbFolderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    // Check if the database file exists, if not, create it
    final File dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      await dbFile.create();
    } else {}
  }
}
