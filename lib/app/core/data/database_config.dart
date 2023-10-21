import 'package:myself_flutter/app/core/data/database_structure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  static Future<Database> getInstance() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'myselff.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE ${DatabaseTables.expense} ('
            'id TEXT PRIMARY KEY,'
            ' paymentDate TEXT,'
            ' description TEXT,'
            ' amount REAL,'
            ' paid NUMERIC)');
      },
      version: 1,
    );
    return database;
  }
}
