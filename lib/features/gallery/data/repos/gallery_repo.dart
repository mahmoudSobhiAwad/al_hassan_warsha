import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:dartz/dartz.dart';

abstract class GalleryRepo {
  Future<
      Either<
          (
            List<KitchenModel> lastAdded,
            List<KitchenTypeModel> allKitchens,
            List<OnlyTypeModel> allTypes
          ),
          String>> getAllGalleryData();
  Future<Either<List<KitchenTypeModel>, String>> getAllKitchenTypes(
      {int offset = 0});
  Future<Either<String, Exception>> addNewKitchenType(
      {required KitchenTypeModel model});
  Future<Either<KitchenTypeModel, Exception>> getChangedTypeModel(
      {required String typeId});
}
