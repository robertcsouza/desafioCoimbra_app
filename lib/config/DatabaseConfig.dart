import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static DatabaseConfig _databaseConfig;
  static Database _database;

// singleton database

  DatabaseConfig._createInstace();

  factory DatabaseConfig() {
    if (_databaseConfig == null) {
      _databaseConfig = DatabaseConfig._createInstace();
    }

    return _databaseConfig;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await inicializaDB();
    }
    return _database;
  }

  Future<Database> inicializaDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'desafioCoimbra.bd';

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print('banco de dados criado');
      },
    );

    return db;
  }

  createTables({Database db, int verson, String sql}) async {
    await db.execute(sql).then((value) => {print('tabela criada')});
  }
}
