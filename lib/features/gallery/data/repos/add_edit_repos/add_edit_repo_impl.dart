import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo.dart';
import 'package:dartz/dartz.dart';


class AddEditKitchenRepoImpl implements AddEditKitchenRepo {
  final DataBaseHelper dataBaseHelper;
  AddEditKitchenRepoImpl({required this.dataBaseHelper});
  @override
  Future<Either<KitchenModel, Exception>> addNewKitchen(
      {required KitchenModel model}) async {
    try {
      await dataBaseHelper.database
          .insert(kitchenItemTableName, model.toJson());
      await updateCounterForType(model.typeId, "+");
      return left(model);
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  @override
  Future<Either<String, Exception>> updateKitchen(
      {required KitchenModel model}) async {
    try {
      await dataBaseHelper.database.update(
        kitchenItemTableName,
        model.toJson(),
        where: 'kitchenId = ?',
        whereArgs: [model.kitchenId],
      );
      return left(model.typeId);
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  Future<void> updateCounterForType(
      String typeId, String manuiplationChar) async {
    try {
      await dataBaseHelper.database.rawUpdate(
        '''
    UPDATE $kitchenTypesTableName 
    SET itemsCount = itemsCount $manuiplationChar 1 
    WHERE typeId = ?
    ''',
        [typeId],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<String, Exception>> deleteKitchen(
      {required String kitchenId, required String typeId}) async {
    try {
      await dataBaseHelper.database.rawDelete('''
      DELETE FROM $kitchenItemTableName WHERE kitchenId = ?;
      ''', [kitchenId]);
      await updateCounterForType(typeId, "-");
      return left(typeId);
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  Future<bool> addMediaInDataBase(
      {required List<PickedMedia> mediaPickedList,
      required String kitchenID}) async {
    if (mediaPickedList.isEmpty) {
      return true;
    } else {
      List<KitchenMedia> kitchenMediaList = [];
      for (var item in mediaPickedList) {
        kitchenMediaList.add(KitchenMedia(
            mediaType: item.mediaType,
            path: item.mediaPath,
            kitchenId: kitchenID,
            kitchenMediaId: item.mediId));
      }
      try {
        List<Map<String, dynamic>> rows =
            kitchenMediaList.map((mediaModel) => mediaModel.toJson()).toList();
        await dataBaseHelper.insertGroupOfRows(
            rows: rows, tableName: galleryKitchenMediaTable);
        return true;
      } catch (e) {
        return false;
      }
    }
  }
}
