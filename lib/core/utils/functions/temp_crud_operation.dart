import 'dart:developer';
import 'dart:io';

import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
import 'package:al_hassan_warsha/core/utils/functions/save_paths.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/salary_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TempCrudOperation {
  static final databaseFactory = databaseFactoryFfi;
  static final String dbTempPath =
      SharedPrefHelper.fetchPathFromShared(tempDataPath) ?? "";

  static Future<void> closeDb() async {
    final db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    await db.close();
    log("db is closed ");
  }

  static Future<void> addIntoTemp(
      {required String tableName, required Map<String, dynamic> data}) async {
    try {
      final Database db = await databaseFactory.openDatabase(
        dbTempPath,
      );
      await db.insert(tableName, data);
      log("success Added In temp");
    } catch (e) {
      log(e.toString());
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
      final Database db = await databaseFactory.openDatabase(dbTempPath);
      await db.delete(tableName, where: whereClause, whereArgs: args);
      log("success deleted from temp");
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<void> addMediaIntoTemp(
      {required List<KitchenMedia> kitchenMediaList}) async {
    try {
      final Database db = await databaseFactory.openDatabase(dbTempPath);
      for (var item in kitchenMediaList) {
        try {
          final tempPath = SharedPrefHelper.fetchPathFromShared(
                  item.mediaType == MediaType.image
                      ? imageTempPath
                      : videoTempPath) ??
              "";

          final fileExtension = item.path.split('.').last;
          item.path =
              '$tempPath${Platform.pathSeparator}${item.kitchenMediaId}.$fileExtension';
        } catch (e) {
          log(e.toString());
          throw Exception(e);
        }
      }
      for (var item in kitchenMediaList) {
        await db.insert(galleryKitchenMediaTable, item.toJson(),conflictAlgorithm:
            ConflictAlgorithm.replace,);
      }

      log("media list is added");
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<void> removeMediaList(
      {required String tableName,
      required String whereClause,
      required List<PickedMedia> mediaIdList}) async {
    final Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    try {
      for (var item in mediaIdList) {
        deleteTempMediaFile(item.mediId, item.mediaPath, item.mediaType);
        await db.delete(
          tableName,
          where: whereClause,
          whereArgs: [item.mediId],
        );
      }
      log("media list is removed");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateWithCommandIntoTemp(
      {required String sqlCommand, List<dynamic> args = const []}) async {
    final Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    try {
      await db.rawUpdate(sqlCommand, args);
      log("Updated is done");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateWithoutCommandIntoTemp(
      {required String tableName,
      required Map<String, dynamic> data,
      String? whereClause,
      List<dynamic> whereArgs = const []}) async {
    final Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    try {
      await db.update(
        tableName,
        data,
        where: whereClause,
        whereArgs: whereArgs,
      );
      log("Updated is done");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateWithoutCommandListOfWorkersIntoTemp({
    required List<WorkerModel> list,
  }) async {
    final db = await databaseFactory.openDatabase(dbTempPath);
    try {
      for (var item in list) {
        await db.update(workersTableName, item.toJson(),
            where: "workerId = ?", whereArgs: [item.workerId]);
      }
       log("updated succesfuly");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> insertExtraList(
      List<ExtraInOrderModel> list, String orderId) async {
    final Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    try {
      for (var item in list) {
        await db.insert(extraOrderTableName, item.toAddJson(orderIdd: orderId));
      }
      log("insert extra list");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> insertWorkersList(
    List<WorkerModel> list,
  ) async {
    final Database db = await databaseFactory.openDatabase(
      dbTempPath,
    );
    try {
      for (var item in list) {
        await db.insert(workersTableName, item.toAddJson());
      }
      log("insert workers list");
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteListCustom(
    List<String> list,
  ) async {
    if (list.isNotEmpty) {
      final Database db = await databaseFactory.openDatabase(
        dbTempPath,
      );
      try {
        for (var item in list) {
          await db.delete(extraOrderTableName,
              where: 'extraId = ?', whereArgs: [item]);
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  static Future<void> deleteOrderWithMedia(
      String orderId, List<MediaOrderModel> mediaList) async {
    try {
      final Database db = await databaseFactory.openDatabase(
        dbTempPath,
      );
      for (var item in mediaList) {
        await deleteTempMediaFile(item.mediaId, item.mediaPath, item.mediaType);
      }
      await db
          .delete(orderTableName, where: 'orderId = ?', whereArgs: [orderId]);

      log("delted order with media success");
    } catch (e) {
      log("error:${e.toString()}");
    }
  }

  static Future<void> deleteSpecifcItem(
      {required String tableName,
      required String whereClause,
      required List args}) async {
    try {
      final db = await databaseFactory.openDatabase(
        dbTempPath,
      );
      await db.delete(tableName, where: whereClause, whereArgs: args);
      log("success removed from temp");
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<void> createNewOrderInTemp(
      OrderModel model, bool forTheSameCustomer) async {
    final Database db = await databaseFactory.openDatabase(dbTempPath);
    try {
      db.transaction((txn) async {
        await txn.insert(orderTableName, model.toJson());
        if (model.customerModel != null && !forTheSameCustomer) {
          await txn.insert(customerTableName, model.customerModel!.toJson());
        }
        if (model.colorModel != null) {
          await txn.insert(
            colorTableName,
            model.colorModel!.toJson(orderIdd: model.orderId),
          );
        }
        if (model.extraOrdersList.isNotEmpty) {
          for (var item in model.extraOrdersList) {
            await txn.insert(
              extraOrderTableName,
              item.toAddJson(orderIdd: model.orderId),
            );
          }
        }
        if (model.mediaOrderList.isNotEmpty) {
          for (var item in model.mediaOrderList) {
            try {
              final tempPath = SharedPrefHelper.fetchPathFromShared(
                      item.mediaType == MediaType.image
                          ? imageTempPath
                          : videoTempPath) ??
                  "";

              final fileExtension = item.mediaPath.split('.').last;
              item.mediaPath =
                  '$tempPath${Platform.pathSeparator}${item.mediaId}.$fileExtension';
            } catch (e) {
              log(e.toString());
              throw Exception(e);
            }
          }
          for (var item in model.mediaOrderList) {
            await txn.insert(
                mediaOrderTableName, item.toAddJson(orderIdd: model.orderId));
          }
          if (model.pillModel != null) {
            await txn.insert(
              pillTableName,
              model.pillModel!.toJson(orderIdd: model.orderId),
            );
          }
        }
        log("add order with transaction way done");
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
