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
      onCreate: _executeCreateDDL,
      onUpgrade: _executeMigrations,
      version: 1,
    );
    return database;
  }

  static void _executeCreateDDL(Database db, version) {
    final batch = db.batch();
    batch.execute('''PRAGMA foreign_keys = ON''');
    batch.execute('''
      CREATE TABLE ${DatabaseTables.paymentMethod} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
      )''');

    batch.execute('''
      CREATE TABLE ${DatabaseTables.expense} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          payment_date TEXT,
          description TEXT,
          amount REAL,
          paid NUMERIC,
          payment_method_id INTEGER,
          FOREIGN KEY (payment_method_id) REFERENCES ${DatabaseTables.paymentMethod}(id) ON DELETE SET NULL
      )''');

    batch.commit();
  }

  static _executeMigrations(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    batch.commit(continueOnError: false);
  }
}
