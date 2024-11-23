import 'package:al_hassan_warsha/core/utils/functions/get_db_path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> openDatabaseHelper() async {
  String path = await getDbPath();
  var databaseFactory = databaseFactoryFfi;
  return databaseFactory.openDatabase(path,
      options: OpenDatabaseOptions(
        version: 5,
      ));
}
