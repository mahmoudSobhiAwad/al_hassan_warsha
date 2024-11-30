import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/core/utils/functions/temp_crud_operation.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:al_hassan_warsha/features/gallery/data/repos/gallery_repo.dart';
import 'package:dartz/dartz.dart';

class GalleryRepoImp implements GalleryRepo {
  final DataBaseHelper dataBaseHelper;
  GalleryRepoImp({required this.dataBaseHelper});
  @override
  Future<
      Either<
          (
            List<KitchenModel> lastAdded,
            List<KitchenTypeModel> allKitchens,
            List<OnlyTypeModel> allTypes
          ),
          String>> getAllGalleryData() async {
    try {
      List<KitchenTypeModel> allKitchenTypes = [];
      List<KitchenModel> lastAddedKitchens = [];
      List<OnlyTypeModel> typesList = [];
      await getAllKitchenTypes().then((value) {
        value.fold((list) {
          allKitchenTypes.addAll(list);
        }, (error) {
          return right(error);
        });
      });

      await loadLastAdded().then((value) {
        value.fold((list) {
          lastAddedKitchens.addAll(list);
        }, (error) {
          return right(error);
        });
      });
      await loadOnlyTypeList().then((value) {
        value.fold((list) {
          typesList.addAll(list);
        }, (error) {
          return right(error);
        });
      });
      return left((lastAddedKitchens, allKitchenTypes, typesList));
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<List<KitchenTypeModel>, String>> getAllKitchenTypes(
      {int offset = 0}) async {
    try {
      final kitchenTypesResult = await dataBaseHelper.database
          .query(kitchenTypesTableName, limit: 5, offset: offset);
      List<KitchenTypeModel> kitchenTypeList = [];

      for (var kitchenTypeItem in kitchenTypesResult) {
        String typeId = kitchenTypeItem["typeId"] as String;

        // Step 2: Fetch kitchens associated with the current typeId
        final kitchenItemsResult = await dataBaseHelper.database.query(
            kitchenItemTableName,
            where: 'typeId = ?',
            whereArgs: [typeId],
            limit: 5);

        List<KitchenModel> kitchenModels = [];

        // Step 3: For each kitchen item, fetch the associated media
        for (var kitchenItem in kitchenItemsResult) {
          String kitchenId = kitchenItem["kitchenId"] as String;

          // Fetch kitchen media associated with the current kitchenId
          final kitchenMediaResult = await dataBaseHelper.database.query(
              galleryKitchenMediaTable,
              where: 'kitchenId = ?',
              whereArgs: [kitchenId],
              limit: 5);

          List<KitchenMedia> kitchenMediaList = kitchenMediaResult.map((media) {
            return KitchenMedia.fromJson(media);
          }).toList();

          // Create KitchenModel object
          KitchenModel kitchenModel = KitchenModel.fromJson(kitchenItem);
          kitchenModel.kitchenMediaList = kitchenMediaList;

          // Add the KitchenModel to the list
          kitchenModels.add(kitchenModel);
        }
        // Create KitchenTypeModel and add it to the list of KitchenType
        KitchenTypeModel kitchenType = KitchenTypeModel.fromJson(
          kitchenTypeItem,
        );
        kitchenType.kitchenList = kitchenModels;
        kitchenTypeList.add(kitchenType);
      }

      return left(kitchenTypeList);
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<String, Exception>> addNewKitchenType(
      {required KitchenTypeModel model}) async {
    try {
      await dataBaseHelper.database
          .insert(kitchenTypesTableName, model.toJson());
      await TempCrudOperation.addIntoTemp(
          tableName: kitchenTypesTableName, data: model.toJson());
      return left("تمت الاضافة بنجاح");
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  @override
  Future<Either<KitchenTypeModel, Exception>> getChangedTypeModel(
      {required String typeId, int limit = 5, int offset = 0}) async {
    try {
      List<KitchenModel> kitchenModelList = [];
      final kitchenTypesResult = await dataBaseHelper.database.query(
          kitchenTypesTableName,
          where: 'typeId = ?',
          whereArgs: [typeId],
          limit: 1);
      final kitchenItemsResult = await dataBaseHelper.database.query(
          kitchenItemTableName,
          where: 'typeId = ?',
          whereArgs: [typeId],
          limit: limit,
          offset: offset);
      for (var kitchenItem in kitchenItemsResult) {
        String kitchenId = kitchenItem["kitchenId"] as String;

        // Fetch kitchen media associated with the current kitchenId
        final kitchenMediaResult = await dataBaseHelper.database.query(
            galleryKitchenMediaTable,
            where: 'kitchenId = ?',
            whereArgs: [kitchenId],
            limit: 5);

        List<KitchenMedia> kitchenMediaList = kitchenMediaResult
            .map((media) => KitchenMedia.fromJson(media))
            .toList();

        KitchenModel kitchenModel = KitchenModel.fromJson(kitchenItem);
        kitchenModel.kitchenMediaList = kitchenMediaList;

        kitchenModelList.add(kitchenModel);
      }
      KitchenTypeModel kitchenType = KitchenTypeModel.fromJson(
        kitchenTypesResult.first,
      );
      kitchenType.kitchenList = kitchenModelList;

      return left(kitchenType);
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  Future<Either<List<OnlyTypeModel>, Exception>> loadOnlyTypeList() async {
    try {
      final kitchenTypesAllResult = await dataBaseHelper.database.query(
        kitchenTypesTableName,
      );
      List<OnlyTypeModel> onlyTypeModelList = [];
      for (var item in kitchenTypesAllResult) {
        onlyTypeModelList.add(OnlyTypeModel.fromJson(item));
      }
      return left(onlyTypeModelList);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Either<List<KitchenModel>, Exception>> loadLastAdded() async {
    try {
      final kitchenTypesAllResult = await dataBaseHelper.database.query(
        kitchenItemTableName,
        orderBy:
            'addedTime DESC', // Sort by the addedTime column in descending order
        limit: 4,
      );
      List<KitchenModel> onlyTypeModelList = [];
      for (var item in kitchenTypesAllResult) {
        String kitchenId = item["kitchenId"] as String;
        final kitchenMediaResult = await dataBaseHelper.database.query(
            galleryKitchenMediaTable,
            where: 'kitchenId = ?',
            whereArgs: [kitchenId],
            limit: 5);
        List<KitchenMedia> kitchenMediaList = kitchenMediaResult.map((media) {
          return KitchenMedia.fromJson(media);
        }).toList();
        KitchenModel model = KitchenModel.fromJson(item);
        model.kitchenMediaList = kitchenMediaList;

        onlyTypeModelList.add(model);
      }
      return left(onlyTypeModelList);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
