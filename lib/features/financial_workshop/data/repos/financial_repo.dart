import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:dartz/dartz.dart';

abstract class FinancialRepo {
  Future<Either<(List<OrderModel>, int), String>>  getAllBills({int? offset});
  Future<Either<PillModel, String>>  downStep(String id,String amount);
}
