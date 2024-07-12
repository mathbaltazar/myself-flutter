import 'package:myselff_flutter/app/core/data/database_config.dart';
import 'package:sqflite_common/sqlite_api.dart';

abstract class CrudRepository<T> {

  static Database? _database;

  Future<List<T>> findAll();

  void save(T entity);

  Future<T?> findById(int id);

  void update(T entity);

  void deleteById(int id);

  Future<Database> getDatabase() async {
    _database ??= await DatabaseConfig.getInstance();
    return _database!;
  }
}
