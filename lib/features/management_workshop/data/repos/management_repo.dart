import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class ManagementRepo {
  Future<Either<String,String>>  createManagmentTables();
  Future<Either<List<OrderModel>,String>> getAllOrders();
  Future<Either<String,String>> createNewOrder(OrderModel model);
}

