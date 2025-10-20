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

    createTablesIfNotExists();

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

  Future<void> createTablesIfNotExists() async {
    final db = await database;

    try {
      db.execute('''
        CREATE TABLE IF NOT EXISTS staff (
          id INTEGER PRIMARY KEY,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          date_of_birth TEXT NOT NULL,
          gender TEXT NOT NULL,
          phone TEXT NOT NULL,
          email TEXT,
          address TEXT,
          emergency_contact_name TEXT,
          emergency_contact_phone TEXT,
          
        )
      ''');
    } catch (error) {
      print('Error creating staff table: $error');
    }
  }
}