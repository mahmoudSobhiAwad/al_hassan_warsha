import 'package:al_hassan_warsha/core/utils/functions/get_db_path.dart';
import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> openDatabaseHelper() async {
  String path = await getDbPath();
  var databaseFactory = databaseFactoryFfi;
  return databaseFactory.openDatabase(path,
      options: OpenDatabaseOptions(
        version: 3,
        onUpgrade: migrateTable,
      ));
}

Future<void> migrateTable(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < newVersion) {
    // Add the `counter` column to the existing table
    await db.execute(
      "ALTER TABLE $kitchenItemTableName ADD COLUMN mediaCounter INTEGER DEFAULT 0",
    );

  }
}
