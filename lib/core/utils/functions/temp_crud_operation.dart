import 'dart:developer';

import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
import 'package:al_hassan_warsha/core/utils/functions/save_paths.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TempCrudOperation {
  static final databaseFactory = databaseFactoryFfi;
  static final String dbTempPath =
      SharedPrefHelper.fetchPathFromShared(tempDataPath) ?? "";
  static Future<void> addIntoTemp(
      {required String tableName, required Map<String, dynamic> data}) async {
    try {
      await databaseFactory.openDatabase(dbTempPath,
          options: OpenDatabaseOptions(onOpen: (db) async {
        await db.insert(tableName, data);
        log("success Added In temp");
      })).then((value) async {
        await value.close();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> removeFromTemp(
      {required String tableName,
      required String whereClause,
      required List<KitchenMedia> kitchenMediaList,
      required List args}) async {
    try {
      for (var item in kitchenMediaList) {
        deleteTempMediaFile(item.kitchenMediaId, item.path, item.mediaType);
      }
      await databaseFactory.openDatabase(dbTempPath,
          options: OpenDatabaseOptions(onOpen: (db) async {
        await db.delete(tableName, where: whereClause, whereArgs: args);
        log("success deleted from temp");
      })).then((value) async {
        await value.close();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> addMediaIntoTemp(
      {required List<KitchenMedia> kitchenMediaList}) async {
    try {
      Database db = await databaseFactory.openDatabase(dbTempPath);
      for (var item in kitchenMediaList) {
        try {
          item.path = await copyMediaFile(
              mediId: item.kitchenMediaId,
              item.path,
              SharedPrefHelper.fetchPathFromShared(
                      item.mediaType == MediaType.image
                          ? imageTempPath
                          : videoTempPath) ??
                  "");
        } catch (e) {
          throw Exception(e);
        }
      }
      for (var item in kitchenMediaList) {
        await db.insert(galleryKitchenMediaTable, item.toJson());
      }
      await db.close();
      log("media list is added");
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> addMediaInOrder(
      {required List<MediaOrderModel> kitchenMediaList,
      required String orderId}) async {
    try {
      Database db = await databaseFactory.openDatabase(dbTempPath);
      for (var item in kitchenMediaList) {
        try {
          item.mediaPath = await copyMediaFile(
              mediId: item.mediaId,
              item.mediaPath,
              SharedPrefHelper.fetchPathFromShared(
                      item.mediaType == MediaType.image
                          ? imageTempPath
                          : videoTempPath) ??
                  "");
        } catch (e) {
          throw Exception(e);
        }
      }
      for (var item in kitchenMediaList) {
        await db.insert(mediaOrderTableName, item.toAddJson(orderIdd: orderId));
      }
      await db.close();
      log("media list is added");
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> removeMediaList(
      {required String tableName,
      required String whereClause,
      required List<PickedMedia> mediaIdList}) async {
    await databaseFactory.openDatabase(dbTempPath,
        options: OpenDatabaseOptions(onOpen: (db) async {
      for (var item in mediaIdList) {
        deleteTempMediaFile(item.mediId, item.mediaPath, item.mediaType);
        await db.delete(
          tableName,
          where: whereClause,
          whereArgs: [item.mediId],
        );
      }
    })).then((db) async {
      await db.close();
    });
  }

  static Future<void> updateWithCommandIntoTemp(
      {required String sqlCommand, List<dynamic> args = const []}) async {
    await databaseFactory.openDatabase(dbTempPath,
        options: OpenDatabaseOptions(onOpen: (db) {
      db.rawUpdate(sqlCommand, args);
    })).then((value) async {
      await value.close();
    });
  }

  static Future<void> updateWithoutCommandIntoTemp(
      {required String tableName,
      required Map<String, dynamic> data,
      String? whereClause,
      List<dynamic> whereArgs = const []}) async {
    await databaseFactory.openDatabase(dbTempPath,
        options: OpenDatabaseOptions(onOpen: (db) {
      db.update(
        tableName,
        data,
        where: whereClause,
        whereArgs: whereArgs,
      );
    })).then((db) async {
      await db.close();
    });
  }

  static Future<void> insertExtraList(
      List<ExtraInOrderModel> list, String orderId) async {
    Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    for (var item in list) {
      await db.insert(extraOrderTableName, item.toAddJson(orderIdd: orderId));
    }
    log("add extra list");
    await db.close();
  }

  static Future<void> deleteListCustom(
    List<String> list,
  ) async {
    Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    for (var item in list) {
      await db
          .delete(extraOrderTableName, where: 'extraId = ?', whereArgs: [item]);
    }
    log("add extra list");
    await db.close();
  }

  static Future<void> deleteOrderWithMedia(
      String orderId, List<MediaOrderModel> mediaList) async {
    try {
      Database db = await databaseFactory.openDatabase(
        dbTempPath,
      );
      for (var item in mediaList) {
        deleteTempMediaFile(item.mediaId, item.mediaPath, item.mediaType);
      }
      await db
          .delete(orderTableName, where: 'orderId = ?', whereArgs: [orderId]);

      log("delted Success");
    } catch (e) {
      log("error:${e.toString()}");
    }
  }
}
