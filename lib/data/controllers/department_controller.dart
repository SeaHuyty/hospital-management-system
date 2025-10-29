import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

class DepartmentController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertDepartment(Department department) async {
    try {
      final db = await _dbHelper.database;

      db.execute('''
        INSERT INTO departments (name)
        VALUES (?)
      ''', [department.name]);

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];
    } catch (error) {
      print("Error inserting department: $error");
      return -1;
    }
  }
}