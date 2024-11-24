import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/color_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/customer_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/extra_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/repos/management_repo.dart';
import 'package:dartz/dartz.dart';

class ManagementRepoImpl implements ManagementRepo {
  final DataBaseHelper dataBaseHelper;
  ManagementRepoImpl({required this.dataBaseHelper});
  @override
  Future<Either<String, String>> createManagmentTables() async {
    try {
      await dataBaseHelper.database.execute('''
CREATE TABLE $customerTableName (
 customerId TEXT PRIMARY KEY,
  customerName TEXT NOT NULL,
  phone TEXT,
  secondPhone TEXT,
  homeAddress TEXT,
);
''');
      await dataBaseHelper.database.execute('''
CREATE TABLE $orderTableName (
  orderId TEXT PRIMARY KEY,
  customerId TEXT NOT NULL,
  recieveTime TEXT NOT NULL,
  orderName TEXT NOT NULL,
  kitchenType TEXT,
  notice TEXT,
  mediaCounter INTEGER DEFAULT 0,
  FOREIGN KEY (customerId) REFERENCES customers(customerId) ON DELETE CASCADE
);
''');

      await dataBaseHelper.database.execute('''
CREATE TABLE $colorTableName (
 colorId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  colorName TEXT,
  colorDegree INTEGER,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      await dataBaseHelper.database.execute('''
CREATE TABLE $extraOrderTableName (
 extraId TEXT PRIMARY KEY,
  extraName TEXT NOT NULL,
  orderId TEXT NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      await dataBaseHelper.database.execute('''
CREATE TABLE $mediaOrderTableName (
 mediaId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  mediaPath TEXT NOT NULL,
  mediaType INTEGER NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      await dataBaseHelper.database.execute('''
CREATE TABLE $pillTableName (
pillId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  totalMoney TEXT NOT NULL,
  interior TEXT NOT NULL,
  optionPaymentWay INTEGER NOT NULL,
  stepsCounter INTEGER NOT NULL,
  customerName TEXT NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      return left("Success Created");
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<List<OrderModel>, String>> getAllOrders(
      {required int month, required int year}) async {
    try {
      String monthString =
          month.toString().padLeft(2, '0'); // Ensure 2-digit format
      String yearString = year.toString();
      final orderReuslt = await dataBaseHelper.database.query(orderTableName,
          where:
              "strftime('%Y', recieveTime) = ? AND strftime('%m', recieveTime) = ?",
          whereArgs: [yearString, monthString]);
      List<OrderModel> orderModelList = [];
      for (var item in orderReuslt) {
        orderModelList.add(await getOtherDataInOrderModel(item));
      }
      return left(orderModelList);
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createNewOrder(OrderModel model) async {
    try {
      // add order model to db
      await dataBaseHelper.database.insert(orderTableName, model.toJson());

      // add customer model into db
      if (model.customerModel != null) {
        await dataBaseHelper.database
            .insert(customerTableName, model.customerModel!.toJson());
      }
      //add color model into db
      if (model.colorModel != null) {
        await dataBaseHelper.database.insert(
            colorTableName, model.colorModel!.toJson(orderIdd: model.orderId));
      }
      // add extra list into db
      if (model.extraOrdersList.isNotEmpty) {
        for (var item in model.extraOrdersList) {
          await dataBaseHelper.database.insert(
              extraOrderTableName, item.toAddJson(orderIdd: model.orderId));
        }
      }
      // add media into db
      if (model.mediaOrderList.isNotEmpty) {
        for (var item in model.mediaOrderList) {
          item.mediaPath = await copyMediaFile(item.mediaPath,
              item.mediaType == MediaType.image ? imageFolder : videoFolder);
          await dataBaseHelper.database.insert(
              mediaOrderTableName, item.toAddJson(orderIdd: model.orderId));
        }
      }
      // add pill payment
      if (model.pillModel != null) {
        await dataBaseHelper.database.insert(
            pillTableName, model.pillModel!.toJson(orderIdd: model.orderId));
      }
      return left(" تمت الاضافة بنجاح ");
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteCurrentOrder(
      String orderId, List<MediaOrderModel> mediaList) async {
    try {
      for (var item in mediaList) {
        deleteMediaFile(item.mediaPath);
      }
      await dataBaseHelper.database
          .delete(orderTableName, where: 'orderId = ?', whereArgs: [orderId]);
      return left("deltedSuccess");
    } catch (e) {
      return right("error:${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> editCurrentOrder(OrderModel model,
      List<String> removedMediPaths, List<String> removedExtra) async {
    try {
      final batch = dataBaseHelper.database.batch();

      for (var item in removedMediPaths) {
        deleteMediaFile(item); // This is fine as it's a file operation.
      }

      for (var item in removedExtra) {
        batch.delete(extraOrderTableName,
            where: 'extraId = ?', whereArgs: [item]);
      }

// Update order
      batch.update(orderTableName, model.toJson(),
          where: 'orderId = ?', whereArgs: [model.orderId]);

// Update customer
      batch.update(customerTableName, model.customerModel!.toJson(),
          where: 'customerId = ?', whereArgs: [model.customerId]);

// Update color
      batch.update(colorTableName, model.colorModel!.toJson(),
          where: 'colorId = ?', whereArgs: [model.colorModel!.colorId]);

// Handle extras (new and updated)
      for (var item in model.extraOrdersList) {
        if (item.extraId.isEmpty) {
          batch.insert(
              extraOrderTableName, item.toAddJson(orderIdd: model.orderId));
        } else {
          batch.update(extraOrderTableName, item.toAddJson(),
              where: 'extraId = ?', whereArgs: [item.extraId]);
        }
      }

// Handle media (new only)
      for (var item in model.mediaOrderList) {
        if (item.mediaId.isEmpty) {
          batch.insert(
              mediaOrderTableName, item.toAddJson(orderIdd: model.orderId));
        }
      }

// Update pill
      batch.update(pillTableName, model.pillModel!.toJson(),
          where: 'pillId = ?', whereArgs: [model.pillModel!.pillId]);

// Commit the batch
      await batch.commit();
      return left("successUpdated");
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<List<OrderModel>, String>> searchForOrders(
      String searchKey, String parmater) async {
    try {
      String searchPattern = '%$searchKey%';
      String columnToSearch;
      switch (parmater) {
        case 'customerName':
          columnToSearch = 'c.customerName';
          break;
        case 'phone':
          columnToSearch = 'c.phone';
          break;
        case 'secondPhone':
          columnToSearch = 'c.secondPhone';
          break;
        case 'homeAddress':
          columnToSearch = 'c.homeAddress';
          break;
        case 'orderName':
          columnToSearch = 'o.orderName';
          break;
        case 'kitchenType':
          columnToSearch = 'o.kitchenType';
          break;
        default:
          throw ArgumentError('Invalid search parameter: $parmater');
      }

      // Execute the SQL query for the specific column
      final List<Map<String, dynamic>> results =
          await dataBaseHelper.database.rawQuery('''
    SELECT o.*
    FROM $orderTableName o
    LEFT JOIN $customerTableName c ON o.customerId = c.customerId
    WHERE $columnToSearch LIKE ?
  ''', [searchPattern]);
      List<OrderModel> searchedList = [];
      for (var item in results) {
        searchedList.add(await getOtherDataInOrderModel(item));
      }
      return left(searchedList);
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<OrderModel> getOtherDataInOrderModel(Map<String, dynamic> item) async {
    try {
      final List<Map<String, dynamic>> results =
          await dataBaseHelper.database.rawQuery('''
      SELECT 
        o.*,
        c.customerName, c.phone, c.secondPhone, c.homeAddress,
        cl.colorId, cl.colorName, cl.colorDegree,
        m.mediaId, m.mediaPath, m.mediaType,
        e.extraId, e.extraName,
        p.pillId, p.customerName, p.stepsCounter, p.optionPaymentWay, p.interior, p.totalMoney
      FROM $orderTableName o
      LEFT JOIN $customerTableName c ON o.customerId = c.customerId
      LEFT JOIN $colorTableName cl ON o.orderId = cl.orderId
      LEFT JOIN $mediaOrderTableName m ON o.orderId = m.orderId
      LEFT JOIN $extraOrderTableName e ON o.orderId = e.orderId
      LEFT JOIN $pillTableName p ON o.orderId = p.orderId
      WHERE o.orderId = ?
    ''', [item['orderId']]);

      if (results.isEmpty) {
        throw Exception('Order not found');
      }

      // Extract the main order data from the first row
      final orderData = results.first;

      CustomerModel? customerModel = orderData['customerId'] != null
          ? CustomerModel.fromJson(orderData)
          : null;
      ColorOrderModel? colorModel = orderData['colorId'] != null
          ? ColorOrderModel.fromJson(orderData)
          : null;
      List<MediaOrderModel> mediaOrderList = results
          .where((row) => row['mediaId'] != null)
          .map((row) => MediaOrderModel.fromJson(row))
          .toList();
      List<ExtraInOrderModel> extraOrdersList = results
          .where((row) => row['extraId'] != null)
          .map((row) => ExtraInOrderModel.fromJson(row))
          .toList();
      PillModel? pillModel =
          orderData['pillId'] != null ? PillModel.fromJson(orderData) : null;

      OrderModel orderModel = OrderModel.fromJson(item);
      orderModel.colorModel = colorModel;
      orderModel.customerModel = customerModel;
      orderModel.mediaOrderList = mediaOrderList;
      orderModel.extraOrdersList = extraOrdersList;
      orderModel.pillModel = pillModel;
      return orderModel;
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
