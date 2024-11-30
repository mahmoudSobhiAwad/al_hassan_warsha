import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  
  Future<Either<bool, String>> createTheSchemaForTheWholeDb(String dataBasePath,{required String tempDataBase});
}
