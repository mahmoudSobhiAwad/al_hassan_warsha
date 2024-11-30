import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddEditKitchenRepo {
  Future<Either<KitchenModel,Exception>>addNewKitchen({required KitchenModel model});
  
  Future<Either<String,Exception>>updateKitchen({required KitchenModel model});

  Future<Either<String,Exception>>deleteKitchen({required String kitchenId,required String typeId,required List<KitchenMedia>mediaPath});

  Future<Either<List<PickedMedia>,Exception>>loadMoreMedia({required String kitchenId,required int offset});
}