import 'package:al_hassan_warsha/core/utils/functions/copy_media_in_directory.dart';
import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo_impl.dart';
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
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

class ManagementRepoImpl implements ManagementRepo {
  final DataBaseHelper dataBaseHelper;
  ManagementRepoImpl({required this.dataBaseHelper});
 

  Future<Either<List<String>, String>> getAllKitchenTypes() async {
    try {
      final result = await dataBaseHelper.database.query(kitchenTypesInOrder);
      List<String> kitchenTypesList = [];
      for (var item in result) {
        kitchenTypesList.add(item['kitchenTypeName'] as String);
      }
      return left(kitchenTypesList);
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<bool, String>> addNewKitchenType(String value) async {
    try {
      await dataBaseHelper.database
          .insert(kitchenTypesInOrder, {"KitchenTypeName": value});

      return left(true);
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
  Future<Either<String, String>> createNewOrder(OrderModel model,{bool forTheSameCustomer=false}) async {
    try {
      Uuid uuid = const Uuid();

      await dataBaseHelper.database.transaction((txn) async {
        // Add order model to the database
        await txn.insert(orderTableName, model.toJson());

        // Add customer model to the database
        if (model.customerModel != null&& !forTheSameCustomer) {
          await txn.insert(customerTableName, model.customerModel!.toJson());
        }

        // Add color model to the database
        if (model.colorModel != null) {
          await txn.insert(
            colorTableName,
            model.colorModel!.toJson(orderIdd: model.orderId),
          );
        }

        // Add extra orders to the database
        if (model.extraOrdersList.isNotEmpty) {
          for (var item in model.extraOrdersList) {
            item.extraId = uuid.v4(); // Ensure unique ID
            await txn.insert(
              extraOrderTableName,
              item.toAddJson(orderIdd: model.orderId),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }

        // Add media orders to the database
        if (model.mediaOrderList.isNotEmpty) {
          for (var item in model.mediaOrderList) {
            item.mediaPath = await copyMediaFile(
              item.mediaPath,
              item.mediaType == MediaType.image ? imageFolder : videoFolder,
            );
            item.mediaId = uuid.v4(); // Ensure unique ID
            await txn.insert(
              mediaOrderTableName,
              item.toAddJson(orderIdd: model.orderId),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }

        // Add pill payment to the database
        if (model.pillModel != null) {
          await txn.insert(
            pillTableName,
            model.pillModel!.toJson(orderIdd: model.orderId),
          );
        }
      });

      await FinancialRepoImpl(dataBaseHelper: dataBaseHelper).addTransaction(
          model: TransactionModel(
              transactionId: uuid.v4(),
              transactionAmount: model.pillModel!.interior,
              allTransactionTypes: AllTransactionTypes.interior,
              transactionMethod: TransactionMethod.caching,
              transactionTime: DateTime.now(),
              transactionType: TransactionType.recieve,
              transactionName: "استلام مقدم من "));
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
    var uuid = const Uuid();
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
          item.extraId = uuid.v4();
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
          item.mediaId = uuid.v4();
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
        p.pillId, p.customerName, p.stepsCounter, p.optionPaymentWay, p.interior, p.totalMoney, p.payedAmount
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

      // Extract customer data
      CustomerModel? customerModel = orderData['customerId'] != null
          ? CustomerModel.fromJson(orderData)
          : null;

      // Extract color data
      ColorOrderModel? colorModel = orderData['colorId'] != null
          ? ColorOrderModel.fromJson(orderData)
          : null;

      // Extract unique media data
      final uniqueMediaIds = <String>{};
      List<MediaOrderModel> mediaOrderList = results
          .where((row) {
            if (row['mediaId'] == null || !uniqueMediaIds.add(row['mediaId'])) {
              return false; // Skip duplicates
            }
            return true;
          })
          .map((row) => MediaOrderModel.fromJson(row))
          .toList();

      // Extract unique extra data
      final uniqueExtraIds = <String>{};
      List<ExtraInOrderModel> extraOrdersList = results
          .where((row) {
            if (row['extraId'] == null || !uniqueExtraIds.add(row['extraId'])) {
              return false; // Skip duplicates
            }
            return true;
          })
          .map((row) => ExtraInOrderModel.fromJson(row))
          .toList();

      // Extract pill data
      PillModel? pillModel =
          orderData['pillId'] != null ? PillModel.fromJson(orderData) : null;

      // Assemble the final OrderModel
      OrderModel orderModel = OrderModel.fromJson(item);
      orderModel.colorModel = colorModel;
      orderModel.customerModel = customerModel;
      orderModel.mediaOrderList = mediaOrderList;
      orderModel.extraOrdersList = extraOrdersList;
      orderModel.pillModel = pillModel;

      return orderModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<String, String>> markOrderAsDone(
      String orderId, int status) async {
    try {
      await dataBaseHelper.database.rawUpdate(
          'Update $orderTableName SET orderStatus = ? WHERE orderId = ? ',
          [status, orderId]);
      return left("success");
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<CustomerModel, String>> getAllCustomerInfo(
      String customerId) async {
    try {
      final allOrderReuslt = await dataBaseHelper.database.query(orderTableName,
          where: 'customerId = ? ', whereArgs: [customerId]);
      List<OrderModel> orderList = [];

      for (var item in allOrderReuslt) {
        orderList.add(await getOtherDataInOrderModel(item));
      }
      CustomerModel customerModel = CustomerModel(
          customerId: customerId,
          customerName: orderList.first.customerModel!.customerName,
          phone: orderList.first.customerModel!.phone,
          homeAddress: orderList.first.customerModel!.homeAddress,
          secondPhone: orderList.first.customerModel!.secondPhone,
          orderModelList: orderList);
      return left(customerModel);
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<PillModel, String>> stepDownFromOrder(
      PillModel pillModel) async {
    try {
      await dataBaseHelper.database.rawUpdate(
        '''
  UPDATE $pillTableName
  SET stepsCounter = CASE
                      WHEN stepsCounter > 0 THEN stepsCounter - 1
                      ELSE 0
                    END, payedAmount = ?
  WHERE pillId = ?
  ''',
        [pillModel.payedAmount, pillModel.pillId],
      );
      final result = await dataBaseHelper.database.query(pillTableName,
          where: 'pillId = ?', whereArgs: [pillModel.pillId]);

      try {
        await dataBaseHelper.database.insert(
            transactionTableName,
            TransactionModel(
                    transactionId: const Uuid().v4(),
                    transactionAmount: pillModel.steppedAmount,
                    transactionMethod: TransactionMethod.caching,
                    allTransactionTypes: AllTransactionTypes.stepDown,
                    transactionTime: DateTime.now(),
                    transactionType: TransactionType.recieve,
                    transactionName: " دفعة ")
                .toJson());
      } catch (e) {
        return right(e.toString());
      }

      return left(PillModel.fromJson(result.first));
    } catch (e) {
      return right(e.toString());
    }
  }
}
