import 'package:myselff_flutter/app/core/data/database_structure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  /* TODO Criar um mecanismo que reconheça o número da oldVersion e aplique as
  *  migrations até a newVersion
  *  Sugestão: criar uma map que guarde as functions de migration?? onde as
  *  as keys são os números da versão ***/

  static Future<Database> getInstance() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'myselff.db'),
      onCreate: (db, version) async {
        var batch = db.batch();
        _executeCreateDDL(batch);
        await batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("UPGRADE EXECUTED !!!!!!!");
      },
      version: 1,
    );
    return database;
  }

  static void _executeCreateDDL(Batch batch) {
    batch.execute('''
      CREATE TABLE ${DatabaseTables.expense} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          paymentDate TEXT,
          description TEXT,
          amount REAL,
          paid NUMERIC
      )''');
  }

}
