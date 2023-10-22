import 'package:sqflite/sqflite.dart';

abstract class Repository<T> {

  final String tableName;

  Repository(this.tableName);

  Future<int> insert(T model);
  Future<int> update(T model);
  Future<int> delete(int id);
  Future<T?> findById(int id);
  Future<List<T>> getAll();
}
