import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
  }

  // Tambah data
  Future<int> insertItem(Map<String, dynamic> item) async {
    Database db = await database;
    return await db.insert('items', item);
  }

  // Ambil semua data
  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await database;
    return await db.query('items');
  }

  // Cari data berdasarkan nama
  Future<List<Map<String, dynamic>>> searchItems(String keyword) async {
    Database db = await database;
    return await db.query(
      'items',
      where: 'name LIKE ?',
      whereArgs: ['%$keyword%'],
    );
  }

  // Update data
  Future<int> updateItem(Map<String, dynamic> item) async {
    Database db = await database;
    return await db.update(
      'items',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  // Hapus data
  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}