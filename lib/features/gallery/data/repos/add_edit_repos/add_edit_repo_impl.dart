import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/core/utils/functions/save_paths.dart';
import 'package:al_hassan_warsha/core/utils/functions/temp_crud_operation.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/add_edit_repos/add_edit_repo.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
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
      await TempCrudOperation.addIntoTemp(
          tableName: kitchenItemTableName, data: model.toJson());
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
      String sqlCommand = '''
    UPDATE $kitchenTypesTableName 
    SET itemsCount = itemsCount $manuiplationChar 1 
    WHERE typeId = ?
    ''';
      await dataBaseHelper.database.rawUpdate(
        sqlCommand,
        [typeId],
      );
      await TempCrudOperation.updateWithCommandIntoTemp(
          sqlCommand: sqlCommand, args: [typeId]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<String, Exception>> deleteKitchen(
      {required String kitchenId,
      required String typeId,
      required List<KitchenMedia> mediaPath}) async {
    try {
      for (var item in mediaPath) {
        await deleteMediaFile(item.path);
      }
      await dataBaseHelper.database.delete(
        kitchenItemTableName,
        where: 'kitchenId = ?',
        whereArgs: [kitchenId],
      );
      await TempCrudOperation.removeFromTemp(
        kitchenMediaList: mediaPath,
          tableName: kitchenItemTableName,
          whereClause: 'kitchenId = ?',
          args: [kitchenId]);
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
            path: await copyMediaFile(
              mediId: item.mediId,
                item.mediaPath,
                SharedPrefHelper.fetchPathFromShared(
                        item.mediaType == MediaType.image
                            ? imageMainPath
                            : videoMainPath) ??
                    ""),
            kitchenId: kitchenID,
            kitchenMediaId: item.mediId));
      }
      try {
        List<Map<String, dynamic>> rows =
            kitchenMediaList.map((mediaModel) => mediaModel.toJson()).toList();
        await dataBaseHelper.insertGroupOfRows(
            rows: rows, tableName: galleryKitchenMediaTable);
        await TempCrudOperation.addMediaIntoTemp(
            kitchenMediaList: kitchenMediaList);
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<bool> removeMediaWithId(List<PickedMedia> mediaIdList) async {
    try {
      for (var item in mediaIdList) {
        await deleteMediaFile(item.mediaPath);
        dataBaseHelper.database.delete(
          galleryKitchenMediaTable,
          where: 'kitchenMediaId = ?',
          whereArgs: [item.mediId],
        );
      }
      await TempCrudOperation.removeMediaList(
          tableName: galleryKitchenMediaTable,
          whereClause: 'kitchenMediaId = ?',
          mediaIdList: mediaIdList);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<List<PickedMedia>, Exception>> loadMoreMedia(
      {required String kitchenId, required int offset}) async {
    try {
      List<PickedMedia> list = [];
      final result = await dataBaseHelper.database.query(
          galleryKitchenMediaTable,
          where: 'kitchenId = ?',
          whereArgs: [kitchenId],
          limit: 5,
          offset: offset);
      for (var item in result) {
        list.add(PickedMedia.fromJson(item));
      }
      return left(list);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
