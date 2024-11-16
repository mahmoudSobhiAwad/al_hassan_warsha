  import 'package:al_hassan_warsha/features/home/data/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getDbPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, dbFolder, dbName);
    return dbPath;
  }