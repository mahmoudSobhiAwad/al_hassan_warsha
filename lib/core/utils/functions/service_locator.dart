import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/core/utils/functions/open_db.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo_impl.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo_impl.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/fetch_media_gallery/fetch_medi.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/gallery_repo_imp.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/repos/management_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final getIt=GetIt.instance;
Future<void>setUp()async{
  getIt.registerSingleton<Database>(await openDatabaseHelper());
  getIt.registerLazySingleton<DataBaseHelper>(()=>DataBaseHelper(database: getIt.get<Database>()));
  getIt.registerLazySingleton<GalleryRepoImp>(()=>GalleryRepoImp(dataBaseHelper: getIt.get<DataBaseHelper>()));
  getIt.registerLazySingleton<AddEditKitchenRepoImpl>(()=>AddEditKitchenRepoImpl(dataBaseHelper: getIt.get<DataBaseHelper>()));
  getIt.registerLazySingleton<FetchMediaRepoImpl>(()=>FetchMediaRepoImpl(dataBaseHelper: getIt.get<DataBaseHelper>()));
  getIt.registerLazySingleton<ManagementRepoImpl>(()=>ManagementRepoImpl(dataBaseHelper: getIt.get<DataBaseHelper>()));
  getIt.registerLazySingleton<FinancialRepoImpl>(()=>FinancialRepoImpl(dataBaseHelper: getIt.get<DataBaseHelper>()));
}
 