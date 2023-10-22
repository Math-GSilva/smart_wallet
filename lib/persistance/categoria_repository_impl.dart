import 'package:sqflite/sqflite.dart';

import '../data/DBHelper.dart';
import '../domain/model/categoria_model.dart';
import '../domain/repository/repository.dart';

class CategoriaRepository extends Repository<Categoria> {
  CategoriaRepository(Database database)
      : super('Categoria');

  @override
  Future<int> insert(Categoria categoria) async {
    Database? db = await DBHelper.instance.database;
    return db.insert(tableName, categoria.toMap());
  }

  @override
  Future<int> update(Categoria categoria) async {
    Database? db = await DBHelper.instance.database;
    return db.update(
      tableName,
      categoria.toMap(),
      where: 'id = ?',
      whereArgs: [categoria.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    Database? db = await DBHelper.instance.database;
    return db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Categoria?> findById(int id) async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Categoria.fromMap(maps.first);
  }

  @override
  Future<List<Categoria>> getAll() async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Categoria.fromMap(maps[i]);
    });
  }
}