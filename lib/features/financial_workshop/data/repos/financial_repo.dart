import 'package:al_hassan_warsha/features/financial_workshop/data/models/transaction_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/order_model.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/pill_model.dart';
import 'package:dartz/dartz.dart';

abstract class FinancialRepo {
  Future<Either<(List<OrderModel>, int), String>>  getAllBills({int? offset,int optionPaymentWay=-1});
  Future<Either<List<OrderModel>, String>>  searchForOrder({ required String searchKeyWord,required String parameterSearch});
  Future<Either<PillModel, String>>  downStep(String id,String amount);
  Future<Either<TransactionModel,String>>addTransaction({required TransactionModel model});
  Future<Either<List<TransactionModel>,String>>getAllTransaction({required int month ,required int year});
}
