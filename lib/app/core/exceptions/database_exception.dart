import 'package:sqflite/sqflite.dart' show DatabaseException;

class LocalDatabaseException implements Exception {
  LocalDatabaseException(this.message);

  final String message;

  factory LocalDatabaseException.fromSQLiteDatabaseException(
          DatabaseException e) =>
      LocalDatabaseException(e.result?.toString() ?? 'Unknown database error');
}
