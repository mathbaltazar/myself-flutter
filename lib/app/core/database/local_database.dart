import 'package:myselff/app/core/constants/database_constants.dart';
import 'package:myselff/app/core/exceptions/database_exception.dart';
import 'package:myselff/app/modules/expenses/data/datasource/local/_collections/expense_collection.dart';
import 'package:myselff/app/modules/expenses/data/datasource/local/_collections/payment_type_collection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  /* TODO Criar um mecanismo que reconheça o número da oldVersion e aplique as
  *  migrations até a newVersion
  *  Sugestão: criar uma map que guarde as functions de migration?? onde as
  *  as keys são os números da versão ***/
  static Database? _db;
  Database get db => _db ??= throw LocalDatabaseException('Database not initialized');

  static initialize() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), '${DatabaseConstants.databaseName}.db'),
      onCreate: _onCreateScript,
      onUpgrade: _onUpgradeScript,
      onOpen: _onOpenScript,
      version: 1,
    );
  }

  static void _onCreateScript(Database db, version) {
    final batch = db.batch();
    batch.execute('''PRAGMA foreign_keys = ON''');
    batch.execute('''
      CREATE TABLE ${PaymentTypeCollection.collectionName} (
          ${PaymentTypeCollection.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${PaymentTypeCollection.name} TEXT NOT NULL UNIQUE
      )''');

    batch.execute('''
      CREATE TABLE ${ExpenseCollection.collectionName} (
          ${ExpenseCollection.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${ExpenseCollection.paymentDate} TEXT NOT NULL,
          ${ExpenseCollection.description} TEXT NOT NULL,
          ${ExpenseCollection.amount} REAL NOT NULL,
          ${ExpenseCollection.paid} NUMERIC,
          ${ExpenseCollection.paymentTypeId} INTEGER,
              FOREIGN KEY (${ExpenseCollection.paymentTypeId})
              REFERENCES ${PaymentTypeCollection.collectionName}(${PaymentTypeCollection.id}) ON DELETE SET NULL
      )''');

    batch.commit();
  }

  static _onUpgradeScript(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    batch.commit(continueOnError: false);
  }

  static void _onOpenScript(Database db) {
    db.execute('''
      PRAGMA foreign_keys = ON
    ''');
  }

  void close() {
    // Closes the database
    _db?.close();
  }
}
