import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBSQLite {
  Database _instance;
  final versionDB = 3;

  static final DBSQLite _db = DBSQLite._internal();

  DBSQLite._internal();

  factory DBSQLite() {
    return _db;
  }

  Future<Database> getInstance() async {
    if (_instance == null) _instance = await _openDatabase();

    return _instance;
  }

  Future<Database> _openDatabase() async {
    var pathDB = await getDatabasesPath();

    var sqlite = await openDatabase(join(pathDB, 'crud_user.db'),
        version: versionDB, onCreate: (db, version) async {
      print('onCreate $version');
      return db.execute('''
              CREATE TABLE users{
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                email TEXT,
                cpf TEXT,
                cep TEXT,
                rua TEXT,
                numero TEXT,
                bairro TEXT,
                cidade TEXT,
                uf TEXT,
                pais TEXT
                }''');
    },

        // atualizações no banco
        //verifica versões e adiciona ou remove mudanças no bd
        onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion > oldVersion) {
        print('upgrade');
        db.execute('''
        CREATE TEABLE dataNascimento{
        dn TEXT}''');
      }
    });
    return sqlite;
  }
}
