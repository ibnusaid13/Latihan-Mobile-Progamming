// lib/uts/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gamingforge.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Membuat tabel favorites
    await db.execute('''
      CREATE TABLE favorites (
        model TEXT PRIMARY KEY,
        brand TEXT,
        price TEXT,
        image TEXT,
        specs TEXT,
        description TEXT
      )
    ''');

    // Membuat tabel cart (BARU)
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        model TEXT,
        brand TEXT,
        price TEXT,
        image TEXT,
        specs TEXT,
        description TEXT
      )
    ''');
  }

  // --- FUNGSI FAVORITES (Tetap seperti sebelumnya) ---
  Future<void> addFavorite(Map<String, dynamic> product) async {
    final db = await instance.database;
    await db.insert('favorites', product, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(String model) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'model = ?', whereArgs: [model]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future<bool> isFavorite(String model) async {
    final db = await instance.database;
    final maps = await db.query('favorites', where: 'model = ?', whereArgs: [model]);
    return maps.isNotEmpty;
  }

  // --- FUNGSI KERANJANG / CART (BARU) ---
  Future<void> addToCart(Map<String, dynamic> product) async {
    final db = await instance.database;
    await db.insert('cart', product);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cart');
  }

  Future<void> removeFromCart(int id) async {
    final db = await instance.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart'); // Menghapus semua data di tabel cart
  }
}