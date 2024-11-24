import 'package:al_hassan_warsha/features/management_workshop/data/models/media_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class ManagementRepo {
  Future<Either<String, String>> createManagmentTables();
  Future<Either<List<OrderModel>, String>> getAllOrders({required int year,required int month});
  Future<Either<String, String>> createNewOrder(OrderModel model);
  Future<Either<String, String>> editCurrentOrder(OrderModel model,List<String> removedMediPaths, List<String> removedExtra);
  Future<Either<String, String>> deleteCurrentOrder(String orderId,List<MediaOrderModel>list);
  Future<Either<List<OrderModel>, String>> searchForOrders(String searchKey,String parma);
  Future<Either<String, String>> markOrderAsDone(String orderId,int status);
}
