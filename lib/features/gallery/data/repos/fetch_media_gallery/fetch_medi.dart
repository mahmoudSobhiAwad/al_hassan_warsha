import 'package:al_hassan_warsha/core/utils/functions/data_base_helper.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:dartz/dartz.dart';

abstract class FetchMediaRepo {
  Future<Either<List<PickedMedia>, String>> fetchMoreMedi(
      {required String kitchenId, int offset = 0});
}

class FetchMediaRepoImpl implements FetchMediaRepo {
  final DataBaseHelper dataBaseHelper;
  FetchMediaRepoImpl({required this.dataBaseHelper});

  @override
  Future<Either<List<PickedMedia>, String>> fetchMoreMedi(
      {required String kitchenId, int offset = 0}) async {
    try {
      List<PickedMedia> pickedList = [];
      final result = await dataBaseHelper.database.query(galleryKitchenMediaTable,
          where: "kitchenId =?",
          whereArgs: [kitchenId],
          limit: 9,
          offset: offset);
      for (var item in result) {
       
        pickedList.add(PickedMedia.fromJson(item));
      }
      return left(pickedList);
    } catch (e) {
      return right(e.toString());
    }
  }
}
