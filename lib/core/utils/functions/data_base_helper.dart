import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseHelper {
  final Database database;
  DataBaseHelper({required this.database});

  Future<bool> checkExistOfColumn({required String tableName}) async {
    var result = await database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return result.isNotEmpty;
  }

  Future<void> insertGroupOfRows(
      {required List<Map<String, dynamic>> rows,
      required String tableName}) async {
    Batch batch = database.batch();
    for (var row in rows) {
      batch.insert(
        tableName,
        row,
        conflictAlgorithm:
            ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

}
