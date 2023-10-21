import 'package:myself_flutter/app/core/data/database_config.dart';
import 'package:sqflite_common/sqlite_api.dart';

abstract class CrudRepository<T> {

  static Database? _database;

  Future<List<T>> findAll();

  void save(T model);

  Future<T?> findById(String id);

  void update(T model);

  void deleteById(String id);

  Future<Database> getDatabase() async {
    _database ??= await DatabaseConfig.getInstance();
    return _database!;
  }
}
