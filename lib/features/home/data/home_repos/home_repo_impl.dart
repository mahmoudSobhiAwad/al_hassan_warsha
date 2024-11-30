import 'dart:io';

import 'package:al_hassan_warsha/features/gallery/data/constants.dart';
import 'package:al_hassan_warsha/features/home/data/home_repos/home_repo.dart';
import 'package:al_hassan_warsha/features/management_workshop/data/models/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<bool, String>> createTheSchemaForTheWholeDb(String dataBasePath,
      {required String tempDataBase}) async {
    // create gallery db :
    try {
      await Future.wait([
        createDatabaseAndOpen(dataBasePath),
        createDatabaseAndOpen(tempDataBase),
      ]);
      //  create temp db

      return left(true);
    } catch (e) {
      print(e.toString());
      return right(e.toString());
    }
  }

  Future<void> createDatabaseAndOpen(String databasePath) async {
    // Create the database file if it doesn't exist
    final file = File(databasePath);
    if (!(await file.exists())) {
      await file.create(recursive: true); // Create the file if not exists
    }
    var databaseFactory = databaseFactoryFfi;
    // Open the database
    await databaseFactory.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          // Table creation logic for both databases
          await createDataTablesForGallery(db);
          await createManagmentTables(db);
          await createFinancialTables(db);
        },
      ),
    );
  }

  Future<void> createDataTablesForGallery(Database db) async {
    await db.execute('''
  CREATE TABLE $kitchenTypesTableName (
    typeId TEXT PRIMARY KEY,       
    typeName TEXT NOT NULL,         
    itemsCount INTEGER DEFAULT 0 
  )
  ''');

    await db.execute('''
  CREATE TABLE $kitchenItemTableName (
    kitchenId TEXT PRIMARY KEY,
    typeId TEXT NOT NULL,
    mediaCounter INTEGER DEFAULT 0,
    kitchenName TEXT,
    kitchenDesc TEXT,
    addedTime TEXT,
    FOREIGN KEY (typeId) REFERENCES KitchenType (typeId) ON DELETE CASCADE
)
  ''');
    await db.execute('''
    CREATE TABLE $galleryKitchenMediaTable (
      kitchenMediaId TEXT PRIMARY KEY,
      path TEXT NOT NULL,
      mediaType INTEGER NOT NULL,
      kitchenId TEXT NOT NULL,
      FOREIGN KEY (kitchenId) REFERENCES kitchens(kitchenId) ON DELETE CASCADE
    );
  ''');
  }

  Future<Either<String, String>> createManagmentTables(Database db) async {
    try {
      await db.execute('''
CREATE TABLE $customerTableName (
 customerId TEXT PRIMARY KEY,
  customerName TEXT NOT NULL,
  phone TEXT,
  secondPhone TEXT,
  homeAddress TEXT,
);
''');
      await db.execute(
          'CREATE INDEX idx_customer_name ON $customerTableName(customerName);');
      await db.execute('''
CREATE TABLE $orderTableName (
  orderId TEXT PRIMARY KEY,
  customerId TEXT NOT NULL,
  recieveTime TEXT NOT NULL,
  orderName TEXT NOT NULL,
  orderStatus INTEGER DEFAULT 0,
  kitchenType TEXT,
  notice TEXT,
  mediaCounter INTEGER DEFAULT 0,
  FOREIGN KEY (customerId) REFERENCES customers(customerId) ON DELETE CASCADE
);
''');
      await db.execute(
          'CREATE INDEX idx_order_name ON $orderTableName(orderName);');
      await db.execute('''
CREATE TABLE $pillTableName (
pillId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  totalMoney TEXT NOT NULL,
  interior TEXT NOT NULL,
  payedAmount TEXT NOT NULL,
  optionPaymentWay INTEGER NOT NULL,
  stepsCounter INTEGER NOT NULL,
  customerName TEXT NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');

      await db.execute('''
CREATE TABLE $colorTableName (
 colorId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  colorName TEXT,
  colorDegree INTEGER,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      await db.execute('''
CREATE TABLE $extraOrderTableName (
 extraId TEXT PRIMARY KEY,
  extraName TEXT NOT NULL,
  orderId TEXT NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');
      await db.execute('''
CREATE TABLE $mediaOrderTableName (
 mediaId TEXT PRIMARY KEY,
  orderId TEXT NOT NULL,
  mediaPath TEXT NOT NULL,
  mediaType INTEGER NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);
''');

      await db.execute('''
CREATE TABLE $kitchenTypesInOrder (
 kitchenTypeName TEXT
);
''');
      for (final kitchenType in kitchenTypesInOrderList) {
        await db.insert(kitchenTypesInOrder, kitchenType);
      }

      return left("Success Created");
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<String, String>> createFinancialTables(Database db) async {
    try {
      await db.execute('''
CREATE TABLE $transactionTableName (
    transactionId TEXT PRIMARY KEY,
    transactionName TEXT NOT NULL,
    transactionAmount TEXT NOT NULL,
    transactionType INTEGER NOT NULL,
    transactionMethod INTEGER NOT NULL,
    transactionTime TEXT NOT NULL,
    transactionAllTypes INTEGER NOT NULL DEFAULT 5
);
''');
      await db.execute(
          '''CREATE INDEX idx_transaction_time ON $transactionTableName(transactionTime)
''');

      await db.execute('''
CREATE TABLE Workers (
    workerId TEXT PRIMARY KEY,
    workerName TEXT NOT NULL,
    workerPhone TEXT,
    salaryType INTEGER NOT NULL DEFAULT 2,
    salaryAmount TEXT NOT NULL DEFAULT '0',
    lastAddedSalary TEXT
);
''');
      return left("l");
    } catch (e) {
      return right(e.toString());
    }
  }
}
