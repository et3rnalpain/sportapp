import 'package:sqflite/sqflite.dart';
import 'package:sportapp/models/foodmodel.dart';
import 'dart:async';

class sqliteDB
{
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async
  {
    if(_db != null) {return;}

    try {
      String _path = await getDatabasesPath() + 'sportappdb';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    }
    catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async =>
      await db.execute('CREATE TABLE food (id INTEGER PRIMARY KEY NOT NULL, name STRING, ccal INTEGER, b INTEGER, j INTEGER, u INTEGER)');

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert(String table, food model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, food model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, food model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}
