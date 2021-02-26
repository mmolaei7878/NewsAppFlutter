import 'package:sqflite/sqflite.dart' as sqf;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sqf.Database> database() async {
    final dbPath = await sqf.getDatabasesPath();
    return sqf.openDatabase(path.join(dbPath, 'saves.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE saves(id TEXT, author TEXT, title TEXT, description TEXT, imageUrl TEXT, date TEXT, content TEXT, url TEXT)');
    }, version: 1);
  }

  static Future<void> insert(Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert('saves', data, conflictAlgorithm: sqf.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await DBHelper.database();
    return db.query('saves');
  }

  static Future<void> delete(String author) async {
    final db = await DBHelper.database();
    return await db.delete(
      'saves',
      where: "author = ?",
      whereArgs: [author],
    );
  }
}
