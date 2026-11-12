import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/resena.dart';

class ResenasDb {
  ResenasDb._();

  static final ResenasDb instancia = ResenasDb._();
  static const _nombreArchivo = 'resenas.db';
  static const _tabla = 'resenas';

  Database? _db;

  Future<Database> get database async {
    _db ??= await _abrir();
    return _db!;
  }

  Future<Database> _abrir() async {
    final ruta = join(await getDatabasesPath(), _nombreArchivo);
    return openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tabla (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            recetaId INTEGER NOT NULL,
            comentario TEXT NOT NULL,
            calificacion REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insert(Resena resena) async {
    final db = await database;
    return db.insert(_tabla, resena.toMap());
  }

  Future<List<Resena>> obtenerPorReceta(int recetaId) async {
    final db = await database;
    final filas = await db.query(
      _tabla,
      where: 'recetaId = ?',
      whereArgs: [recetaId],
      orderBy: 'id DESC',
    );
    return filas.map(Resena.fromMap).toList();
  }

  Future<int> eliminar(int id) async {
    final db = await database;
    return db.delete(_tabla, where: 'id = ?', whereArgs: [id]);
  }
}