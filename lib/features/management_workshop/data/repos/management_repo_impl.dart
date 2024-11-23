import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
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
CREATE TABLE $customerTableName (
 customerId TEXT PRIMARY KEY,
  customerName TEXT NOT NULL,
  phone TEXT,
  secondPhone TEXT
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
  Future<Either<List<OrderModel>, String>> getAllOrders() async {
    try {
      final orderReuslt = await dataBaseHelper.database.query(orderTableName);
      List<OrderModel> orderModelList = [];
      for (var item in orderReuslt) {
        final customerResult = await dataBaseHelper.database.query(
          customerTableName,
          where: 'customerId = ?',
          whereArgs: [item['customerId']],
        );
        final colorResult = await dataBaseHelper.database.query(
          colorTableName,
          where: 'orderId   = ?',
          whereArgs: [item['orderId']],
        );
        final mediaResult = await dataBaseHelper.database.query(
          mediaOrderTableName,
          where: 'orderId = ?',
          whereArgs: [item['orderId']],
        );
        final extraResult = await dataBaseHelper.database.query(
          extraOrderTableName,
          where: 'orderId = ?',
          whereArgs: [item['orderId']],
        );
        final pillResult = await dataBaseHelper.database.query(
          pillTableName,
          where: 'orderId = ?',
          whereArgs: [item['orderId']],
        );

        CustomerModel? customerModel = customerResult.isNotEmpty
            ? CustomerModel.fromJson(customerResult.first)
            : null;
        ColorOrderModel? colorModel = colorResult.isNotEmpty
            ? ColorOrderModel.fromJson(colorResult.first)
            : null;
        List<MediaOrderModel> mediaOrderList = mediaResult
            .map((mediaRow) => MediaOrderModel.fromJson(mediaRow))
            .toList();
        List<ExtraInOrderModel> extraOrdersList = extraResult
            .map((extraRow) => ExtraInOrderModel.fromJson(extraRow))
            .toList();
        PillModel? pillModel =
            pillResult.isNotEmpty ? PillModel.fromJson(pillResult.first) : null;

        OrderModel orderModel = OrderModel.fromJson(item);
        orderModel.colorModel = colorModel;
        orderModel.customerModel = customerModel;
        orderModel.mediaOrderList = mediaOrderList;
        orderModel.extraOrdersList = extraOrdersList;
        orderModel.pillModel = pillModel;
        orderModelList.add(orderModel);
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
            await dataBaseHelper.database.insert(
                mediaOrderTableName, item.toAddJson(orderIdd: model.orderId));
          }
        }
        // add pill payment
        if (model.pillModel != null) {
          await dataBaseHelper.database.insert(
              pillTableName, model.pillModel!.toJson(orderIdd: model.orderId));
        }
      }
      return left(" تمت الاضافة بنجاح ");
    } catch (e) {
      return right(e.toString());
    }
  }
}
