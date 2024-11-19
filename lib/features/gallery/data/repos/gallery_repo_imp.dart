import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
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

    await dataBaseHelper.database.execute('''
  CREATE TABLE $kitchenItemTableName (
    kitchenId TEXT PRIMARY KEY,
    typeId TEXT NOT NULL,
    kitchenName TEXT,
    kitchenDesc TEXT,
    addedTime TEXT,
    FOREIGN KEY (typeId) REFERENCES KitchenType (typeId) ON DELETE CASCADE
)
  ''');
    await dataBaseHelper.database.execute('''
    CREATE TABLE $galleryKitchenMediaTable (
      kitchenMediaId TEXT PRIMARY KEY,
      path TEXT NOT NULL,
      mediaType INTEGER NOT NULL,
      kitchenId TEXT NOT NULL,
      FOREIGN KEY (kitchenId) REFERENCES kitchens(kitchenId) ON DELETE CASCADE
    );
  ''');
  }

  @override
  Future<Either<List<KitchenTypeModel>, String>> getAllKitchenTypes() async {
    try {

      final kitchenTypesResult =
          await dataBaseHelper.database.query(kitchenTypesTableName);

      List<KitchenTypeModel> kitchenTypeList = [];

      for (var kitchenTypeItem in kitchenTypesResult) {
        String typeId = kitchenTypeItem["typeId"] as String;

        // Step 2: Fetch kitchens associated with the current typeId
        final kitchenItemsResult = await dataBaseHelper.database.query(
          kitchenItemTableName,
          where: 'typeId = ?',
          whereArgs: [typeId],
        );

        List<KitchenModel> kitchenModels = [];

        // Step 3: For each kitchen item, fetch the associated media
        for (var kitchenItem in kitchenItemsResult) {
          String kitchenId = kitchenItem["kitchenId"] as String;

          // Fetch kitchen media associated with the current kitchenId
          final kitchenMediaResult = await dataBaseHelper.database.query(
            galleryKitchenMediaTable,
            where: 'kitchenId = ?',
            whereArgs: [kitchenId],
          );

          List<KitchenMedia> kitchenMediaList = kitchenMediaResult
              .map((media) => KitchenMedia.fromJson(media))
              .toList();

          // Create KitchenModel object
          KitchenModel kitchenModel =
              KitchenModel.fromJson(kitchenItem);
              kitchenModel.kitchenMediaList=kitchenMediaList;
             
          // Add the KitchenModel to the list
          kitchenModels.add(kitchenModel);
        }

        // Create KitchenTypeModel and add it to the list of KitchenType
        KitchenTypeModel kitchenType = KitchenTypeModel.fromJson(
            kitchenTypeItem,
            );
            kitchenType.kitchenList=kitchenModels;
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
      return left("تمت الاضافة بنجاح");
    } catch (e) {
      return right(Exception(e.toString()));
    }
  }

  Future<List<KitchenTypeModel>> tryAnotherWayToFetchData() async {
    final result = await dataBaseHelper.database.rawQuery('''
    SELECT 
        kt.typeId AS typeId,
        kt.typeName AS typeName,
        k.kitchenId AS kitchenId,
        k.kitchenName AS kitchenName,
        k.kitchenDesc AS kitchenDesc,
        k.addedTime AS kitchenAddedTime,
        km.kitchenMediaId AS mediaId,
        km.path AS mediaPath,
        km.mediaType AS mediaType
    FROM 
        $kitchenTypesTableName kt
    LEFT JOIN 
        $kitchenItemTableName k ON kt.typeId = k.typeId
    LEFT JOIN 
        $galleryKitchenMediaTable km ON k.kitchenId = km.kitchenId
    ORDER BY 
        kt.typeName, k.kitchenName, km.mediaType;
  ''');

    // Group results by `typeId`
    Map<String, List<Map<String, dynamic>>> groupedData = {};
    for (var row in result) {
      final typeId = row['typeId'] as String;
      groupedData.putIfAbsent(typeId, () => []).add(row);
    }

    // Parse grouped data into models
    List<KitchenTypeModel> kitchenTypesList = groupedData.entries.map((entry) {
      final typeId = entry.key;
      final rows = entry.value;

      final kitchensList = <KitchenModel>[];
      final mediaMap = <String, List<KitchenMedia>>{};

      for (var row in rows) {
        // Add KitchenItems
        final kitchenId = row['kitchenId'] as String?;
        if (kitchenId != null &&
            !kitchensList.any((k) => k.kitchenId == kitchenId)) {
          kitchensList.add(KitchenModel(
            typeId: typeId,
            kitchenId: kitchenId,
            kitchenName: row['kitchenName'] as String?,
            kitchenDesc: row['kitchenDesc'] as String?,
            addedDate: DateTime.parse(row['kitchenAddedTime'] as String),
          ));
        }

        // Add KitchenMedia
        final mediaId = row['mediaId'] as String?;
        if (mediaId != null) {
          mediaMap.putIfAbsent(kitchenId!, () => []).add(KitchenMedia(
                kitchenId: "",
                kitchenMediaId: mediaId,
                path: row['mediaPath'] as String,
                mediaType: MediaType.values[row['mediaType'] as int],
              ));
        }
      }

      // Attach media to kitchens
      for (var kitchen in kitchensList) {
        kitchen.kitchenMediaList = mediaMap[kitchen.kitchenId] ?? [];
      }

      return KitchenTypeModel(
        typeId: typeId,
        typeName: rows.first['typeName'] as String,
        kitchenList: kitchensList,
      );
    }).toList();

    return kitchenTypesList;
  }
}
