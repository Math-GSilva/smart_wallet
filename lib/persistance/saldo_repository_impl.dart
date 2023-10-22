import 'package:sqflite/sqflite.dart';

import '../data/DBHelper.dart';
import '../domain/model/saldo_model.dart';
import '../domain/repository/repository.dart';

class SaldoRepository extends Repository<Saldo> {
  SaldoRepository(Database database)
      : super( 'Saldo');

  @override
  Future<int> insert(Saldo saldo) async {
    Database? db = await DBHelper.instance.database;
    return db.insert(tableName, saldo.toMap());
  }

  @override
  Future<int> update(Saldo saldo) async {
    Database? db = await DBHelper.instance.database;
    return db.update(
      tableName,
      saldo.toMap(),
      where: 'id = ?',
      whereArgs: [saldo.id],
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
  Future<Saldo?> findById(int id) async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Saldo.fromMap(maps.first);
  }

  @override
  Future<List<Saldo>> getAll() async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Saldo.fromMap(maps[i]);
    });
  }
}