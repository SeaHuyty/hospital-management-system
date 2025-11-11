import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';

class AdministratorControllers {
  Future<void> insertAdministrator(Administrator administrator) async {
    final db = await DatabaseHelper().database;
    StaffControllers staffController = StaffControllers();

    int staffId = await staffController.insertBaseStaff(administrator);
    if (staffId == -1) {
      print('Error inserting administrator');
      return;
    }

    try {
      db.execute(
        '''
        INSERT INTO administrators (
          staff_id,
          username,
          password,
          department
        ) VALUES (?, ?, ?, ?)
      ''',
        [
          staffId,
          administrator.username,
          administrator.password,
          administrator.department,
        ],
      );
    } catch (error) {
      print('Error inserting administrator details: $error');
    }
  }

  Future<List<Administrator>> getAllAdministrators() async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('''SELECT
          s.*, 
          a.username,
          a.password,
          a.department
        FROM staff s
        INNER JOIN administrators a ON s.id = a.staff_id
        WHERE s.staff_type = 'administrator'
        ORDER BY s.last_name, s.first_name;''');

      return result.map((row) => Administrator.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching administrators: $error');
      return [];
    }
  }

  Future<bool> updateAdministratorField(
    String staffId,
    String fieldName,
    String newValue,
  ) async {
    try {
      final db = await DatabaseHelper().database;

      String columnName;
      switch (fieldName) {
        case 'username':
          columnName = 'username';
          break;
        case 'password':
          columnName = 'password';
          break;
        case 'department':
          columnName = 'department';
          break;
        default:
          print('Error: Unknown administrator field name $fieldName');
          return false;
      }

      db.execute(
        'UPDATE administrators SET $columnName = ? WHERE staff_id = ?',
        [newValue, staffId],
      );

      print('Administrator $fieldName updated successfully');
      return true;
    } catch (error) {
      print('Error updating administrator field: $error');
      return false;
    }
  }

  Future<Administrator?> getAdministratorByStaffId(String staffId) async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select(
        '''SELECT
          s.*, 
          a.username,
          a.password,
          a.department
        FROM staff s
        INNER JOIN administrators a ON s.id = a.staff_id
        WHERE s.id = ? AND s.staff_type = 'administrator';''',
        [staffId],
      );

      if (result.isNotEmpty) {
        return Administrator.fromMap(result.first);
      }
      return null;
    } catch (error) {
      print('Error fetching administrator by staff ID: $error');
      return null;
    }
  }
}
