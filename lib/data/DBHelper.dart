import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'smart_wallet_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.transaction((txn) async {
          await txn.execute('''
            CREATE TABLE IF NOT EXISTS Categoria (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              descricao TEXT
            )
          ''');
          await txn.execute('''
            CREATE TABLE IF NOT EXISTS Movimentacao (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              categoriaId INTEGER,
              data TEXT,
              descricao TEXT,
              valor REAL,
              tipo TEXT,
              FOREIGN KEY (categoriaId) REFERENCES Categoria (id)
            )
          ''');
          await txn.execute('''
            CREATE TABLE IF NOT EXISTS Saldo (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              saldoAtual REAL,
              ultimaAtualizacao TEXT
            )
          ''');
        });
      },
    );
  }
}
