import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/gallery_repo.dart';
import 'package:dartz/dartz.dart';

class GalleryRepoImp implements GalleryRepo {
  final DataBaseHelper dataBaseHelper;
  GalleryRepoImp({required this.dataBaseHelper});
  @override
  Future<bool> checkDbExistOfGalleryTables({required String tableName}) async {
    try {
      return await dataBaseHelper.checkExistOfColumn(tableName: tableName);
    } catch (e) {
      throw Exception(e.toString());
    }
  
  }

  @override
  Future<void> createDataTablesForGallery() async {
    await dataBaseHelper.database.execute('''
  CREATE TABLE $kitchenTypesTableName (
    typeId TEXT PRIMARY KEY,       
    typeName TEXT NOT NULL,         
    itemsCount INTEGER DEFAULT 0 
  )
  ''');
  }

  @override
  Future<Either<List<KitchenTypeModel>, String>> getAllKitchenTypes() async {
    try {
      
      final result = await dataBaseHelper.database.query(kitchenTypesTableName);
      
      List<KitchenTypeModel>kitchenTypesList=[];
      for(var item in result){
        kitchenTypesList.add(KitchenTypeModel.fromJson(item));
      }
      return left(kitchenTypesList);
    } catch (e) {
      return right(e.toString());
    }
  }
  
  @override
  Future<Either<String, Exception>> addNewKitchenType({required KitchenTypeModel model}) async{
    try {
      await dataBaseHelper.database.insert(kitchenTypesTableName,model.toJson());
      return left("تمت الاضافة بنجاح");
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }
}
