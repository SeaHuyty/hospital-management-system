import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Create databases directory if it doesn't exist
    final dbDir = Directory('databases');
    if (!await dbDir.exists()) {
      await dbDir.create();
    }
    
    String path = join(dbDir.path, 'hospital.db');
    return sqlite3.open(path);
  }

  Future<bool> connectToDatabase() async {
    try {
      final db = await database;
      // Test the connection by executing a simple query
      db.execute('SELECT 1');
      return true;
    } catch (error) {
      print('Database connection error: $error');
      return false;
    }
  }
}