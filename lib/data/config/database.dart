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
    try {
      // Create databases directory if it doesn't exist
      final dbDir = Directory('databases');
      if (!await dbDir.exists()) {
        await dbDir.create();
      }

      String path = join(dbDir.path, 'hospital.db');

      final db = sqlite3.open(path);

      // Create tables after opening database
      await createTablesIfNotExists(db);

      print('Database initialized successfully at: $path');
      return db;
    } catch (error) {
      print('Error initializing database: $error');
      rethrow;
    }
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

  Future<void> createTablesIfNotExists(Database db) async {
    try {
      // Base staff table
      db.execute('''
        CREATE TABLE IF NOT EXISTS staff (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          date_of_birth TEXT NOT NULL,
          gender TEXT NOT NULL,
          phone TEXT NOT NULL,
          email TEXT,
          address TEXT,
          emergency_contact_name TEXT,
          emergency_contact_phone TEXT,
          hire_date TEXT NOT NULL,
          employment_status TEXT CHECK(employment_status IN('active', 'leave', 'terminated')),
          shift TEXT NOT NULL,
          salary REAL NOT NULL,
          staff_type TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');

      // Doctor-specific table
      db.execute('''
        CREATE TABLE IF NOT EXISTS doctors (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          staff_id INTEGER NOT NULL,
          specialization TEXT NOT NULL,
          license_number TEXT NOT NULL,
          qualification TEXT NOT NULL,
          FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
        )
      ''');

      // Nurse-specific table
      db.execute('''
        CREATE TABLE IF NOT EXISTS nurses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          staff_id INTEGER NOT NULL,
          department TEXT NOT NULL,
          certification TEXT NOT NULL,
          FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
        )
      ''');

      // Security-specific table
      db.execute('''
        CREATE TABLE IF NOT EXISTS security (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          staff_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          assigned_area TEXT NOT NULL,
          FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
        )
      ''');

      // Cleaner-specific table
      db.execute('''
        CREATE TABLE IF NOT EXISTS cleaners (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          staff_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          assigned_department TEXT NOT NULL,
          assigned_area TEXT NOT NULL,
          FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
        )
      ''');

      db.execute('''
        CREATE TABLE IF NOT EXISTS administrators (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          staff_id INTEGER NOT NULL,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          department TEXT NOT NULL,
          is_locked INTEGER DEFAULT 0,
          lastLogin TEXT,
          FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
        )
      ''');

      db.execute('''
        CREATE TABLE IF NOT EXISTS logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL,
          action TEXT NOT NULL,
          time TEXT NOT NULL
        )
      ''');
    } catch (error) {
      print('Error creating staff table: $error');
    }
  }

  // Method to drop all tables for development and testing
  Future<void> dropAllTables() async {
    try {
      final db = await database;

      db.execute('DROP TABLE IF EXISTS logs');
      db.execute('DROP TABLE IF EXISTS administrators');
      db.execute('DROP TABLE IF EXISTS cleaners');
      db.execute('DROP TABLE IF EXISTS security');
      db.execute('DROP TABLE IF EXISTS nurses');
      db.execute('DROP TABLE IF EXISTS doctors');
      db.execute('DROP TABLE IF EXISTS staff');

      print('All tables dropped successfully');
    } catch (error) {
      print('Error dropping tables: $error');
    }
  }

  // Method to recreate all tables
  Future<void> recreateTables() async {
    try {
      final db = await database;
      await dropAllTables();
      await createTablesIfNotExists(db);
      print('Tables recreated successfully');
    } catch (error) {
      print('Error in recreating tables: $error');
    }
  }
}