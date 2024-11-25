import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/financial_workshop/data/repos/financial_repo.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:dartz/dartz.dart';

class FinancialRepoImpl implements FinancialRepo {
  final DataBaseHelper dataBaseHelper;
  FinancialRepoImpl({required this.dataBaseHelper});
  @override
  Future<Either<(List<OrderModel>, int), String>> getAllBills(
      {int? offset}) async {
    try {
      final result = await dataBaseHelper.database.query(
        orderTableName,
        limit: 8,
      );
      List<OrderModel> orderList = [];
      for (var item in result) {
        final pillresult = await dataBaseHelper.database.query(pillTableName,
            where: 'orderId =?', whereArgs: [item['orderId']]);
        PillModel pillModel = PillModel.fromJson(pillresult.first);
        OrderModel orderModel = OrderModel.fromJson(item);
        orderModel.pillModel = pillModel;
        orderList.add(orderModel);
      }
      int? totalLength = await getTableCount(orderTableName) ?? 0;

      return left((orderList, totalLength));
    } catch (e) {
      return right(e.toString());
    }
  }

  @override
  Future<Either<PillModel, String>> downStep(
      String pillId, String remainAmount) async {
    try {
      if (double.parse(remainAmount) > 1) {
        await dataBaseHelper.database.rawUpdate(
          '''
  UPDATE $pillTableName
  SET stepsCounter = stepsCounter - 1, remainMoney = ?
  WHERE pillId = ?
  ''',
          [remainAmount, pillId],
        );
      } else {
        await dataBaseHelper.database.rawUpdate(
          '''
  UPDATE $pillTableName
  SET stepsCounter = ?, remainMoney = ?
  WHERE pillId = ?
  ''',
          [0, remainAmount, pillId],
        );
      }
      final result = await dataBaseHelper.database
          .query(pillTableName, where: 'pillId = ?', whereArgs: [pillId]);
      return left(PillModel.fromJson(result.first));
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<int?> getTableCount(String tableName) async {
    try {
      // Query to count rows in the specific table
      final result = await dataBaseHelper.database
          .rawQuery("SELECT COUNT(*) as count FROM $tableName");
      return result.first['count'] != null ? result.first['count'] as int : 0;
      // Extract the count or return 0 if null
    } catch (e) {
      // Handle error, optionally log or throw
      return 0;
    }
  }
}
