import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_type.dart';
import 'package:dartz/dartz.dart';

abstract class GalleryRepo {
  Future<void>createDataTablesForGallery();
  Future<bool>checkDbExistOfGalleryTables({required String tableName});
  Future<Either<List<KitchenTypeModel>,String>> getAllKitchenTypes();
  Future<Either<String,Exception>> addNewKitchenType({required KitchenTypeModel model});
}