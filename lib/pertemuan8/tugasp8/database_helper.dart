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
    // Membuat database dengan nama akademik.db
    String path = join(await getDatabasesPath(), 'akademik.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    // Membuat tabel mahasiswa
    await db.execute('''
      CREATE TABLE mahasiswa(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT,
        nama TEXT,
        jurusan TEXT
      )
    ''');
  }

  // Tambah Mahasiswa
  Future<int> insertMahasiswa(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(
      'mahasiswa', 
      row,
      // Mencegah error duplikasi data dengan menimpa data lama jika ID sama
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Ambil Semua Data Mahasiswa (Terurut Abjad A-Z)
  Future<List<Map<String, dynamic>>> getMahasiswa() async {
    Database db = await database;
    return await db.query(
      'mahasiswa',
      orderBy: 'nama ASC', // Mengurutkan berdasarkan nama A-Z
    );
  }

  // Cari Mahasiswa berdasarkan Nama atau NIM (Terurut Abjad A-Z)
  Future<List<Map<String, dynamic>>> searchMahasiswa(String keyword) async {
    Database db = await database;
    return await db.query(
      'mahasiswa',
      where: 'nama LIKE ? OR nim LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'nama ASC', // Hasil pencarian juga diurutkan
    );
  }

  // Update Data Mahasiswa
  Future<int> updateMahasiswa(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'mahasiswa',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  // Hapus Data Mahasiswa
  Future<int> deleteMahasiswa(int id) async {
    Database db = await database;
    return await db.delete(
      'mahasiswa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}