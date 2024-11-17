import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddEditKitchenRepo {
  Future<Either<String,Exception>>addNewKitchen({required KitchenModel model});
  
  Future<Either<String,Exception>>updateKitchen({required KitchenModel model});
}