import 'dart:async';
import 'dart:io';
import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
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
    on<NaveToExportFromTempEvent>(navToExportDialog);
    on<ExportFromTempDataEvent>(backUpTheDate);
    on<ChangePageInPhoneLayoutEvent>(changePageInPhone);
  }
  bool isExist = false;
  bool isLoading = false;
  int currPageIndex = 0;
  String? tempPath;
  String? backUpPath;
  String mediaPath = Directory(
          '${Platform.environment['LOCALAPPDATA']}/$appName/$mediaBasicFolder')
      .path;
  FutureOr<void> changePage(
      ChangeCurrentPageEvent event, Emitter<HomeBasicState> emit) async {
    currIndex = event.currIndex;

    emit(ToggleBetweenPagesState(currIndex: currIndex));
  }

  FutureOr<void> changePageInPhone(
      ChangePageInPhoneLayoutEvent event, Emitter<HomeBasicState> emit) async {
    currPageIndex = event.pageIndex;

    emit(ChangePageInPhoneLayOutState());
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
        event.isRestoring ? backUpPath = value : tempPath = value;
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
    if (tempPath != null) {
      String dbPath = join(appDocumentsDir.path, dbFolder, dbName);
      String dbTempPath = join(tempPath!, tempFolder, dbFolder, dbTempName);
      String imagePaths = join(mediaPath, imageFolder);
      String videoPaths = join(mediaPath, videoFolder);
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
      result.fold((check) async {
        isLoading = false;
        isExist = true;
        emit(CreateDataBaseSuccessState());
      }, (error) {
        isLoading = false;
        emit(CreateDataBaseFailedState(errMessage: error));
      })?.then((value) async {
        await setUp();
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

  FutureOr<void> navToExportDialog(
      NaveToExportFromTempEvent event, Emitter<HomeBasicState> emit) async {
    emit(ShowExportDialog());
  }

  FutureOr<void> backUpTheDate(
      ExportFromTempDataEvent event, Emitter<HomeBasicState> emit) async {
    isLoading = true;
    if (backUpPath != null) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      String dbPath = join(appDocumentsDir.path, dbFolder);
      try {
        String packUpDbPath = join(backUpPath!, dbFolder, dbTempName);
        await copyDbFileFromTemp(packUpDbPath, dbPath, newFileName: dbName);
        String imagePaths = join(mediaPath, imageFolder);
        String videoPaths = join(mediaPath, videoFolder);
        String tempImagePath = join(backUpPath!, dbFolder, imageFolder);
        String tempVideoPath = join(backUpPath!, dbFolder, videoFolder);
        createFolder(imagePaths);
        createFolder(videoPaths);
        await SharedPrefHelper.saveFolderPath({
          imageMainPath: imagePaths,
          videoMainPath: videoPaths,
          imageTempPath: tempImagePath,
          videoTempPath: tempVideoPath,
          tempDataPath: packUpDbPath,
        });
        isLoading = false;
        isExist = true;
        await setUp();
        emit(ExportDataBaseSuccessState());
      } catch (e) {
        emit(ExportDataBaseFailedState(errMessage: e.toString()));
      }
    } else {
      isLoading = false;
      emit(ExportDataBaseFailedState(
          errMessage: "هذا الملف فارغ او غير متوافق "));
    }
  }
}
