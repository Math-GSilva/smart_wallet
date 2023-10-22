import 'package:smart_wallet/data/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/model/movimentacao_model.dart';
import '../domain/repository/repository.dart';

class MovimentacaoRepository extends Repository<Movimentacao> {
  MovimentacaoRepository()
      : super('Movimentacao');

  @override
  Future<int> insert(Movimentacao movimentacao) async {
    Database? db = await DBHelper.instance.database;
    return db.insert(tableName, movimentacao.toMap());
  }

  @override
  Future<int> update(Movimentacao movimentacao) async {
    Database? db = await DBHelper.instance.database;
    return db.update(
      tableName,
      movimentacao.toMap(),
      where: 'id = ?',
      whereArgs: [movimentacao.id],
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
  Future<Movimentacao?> findById(int id) async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Movimentacao.fromMap(maps.first);
  }

  @override
  Future<List<Movimentacao>> getAll() async {
    Database? db = await DBHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Movimentacao.fromMap(maps[i]);
    });
  }
}