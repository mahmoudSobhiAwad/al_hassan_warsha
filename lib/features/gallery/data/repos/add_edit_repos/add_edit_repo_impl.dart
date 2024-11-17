import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo.dart';
import 'package:dartz/dartz.dart';

class AddEditKitchenRepoImpl implements AddEditKitchenRepo {
  final DataBaseHelper dataBaseHelper;
  AddEditKitchenRepoImpl({required this.dataBaseHelper});
  @override
  Future<Either<String, Exception>> addNewKitchen(
      {required KitchenModel model}) async {
    try {
      await dataBaseHelper.database
          .insert(kitchenItemTableName, model.toJson());
      await updateCounterForType(model.typeId);
      return left("تمت الاضافة بنجاح");
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  @override
  Future<Either<String, Exception>> updateKitchen(
      {required KitchenModel model}) {
    // TODO: implement updateKitchen
    throw UnimplementedError();
  }

  Future<void> updateCounterForType(String typeId) async {
    try{
      await dataBaseHelper.database.rawUpdate(
      '''
    UPDATE $kitchenTypesTableName 
    SET itemsCount = itemsCount + 1 
    WHERE typeId = ?
    ''',
      [typeId],
    );
    }
    catch(e){
      throw Exception(e.toString());
    }
    
  }
}
