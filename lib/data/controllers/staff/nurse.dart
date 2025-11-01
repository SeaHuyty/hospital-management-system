import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';
import 'package:hospital_management_system/data/config/database.dart';

class NurseControllers {
  Future<void> insertNurse(Nurse nurse) async {
    final db = await DatabaseHelper().database;
    StaffControllers staffController = StaffControllers();

    int staffId = await staffController.insertBaseStaff(nurse);
    if (staffId == -1) {
      print('Error inserting nurse');
      return;
    }

    try {
      db.execute(
        '''
        INSERT INTO nurses (
          staff_id,
          department,
          certification
        ) VALUES (?, ?, ?)
      ''',
        [staffId, nurse.department, nurse.certification],
      );
    } catch (error) {
      print('Error inserting nurse details: $error');
    }
  }

  Future<List<Nurse>> getAllNurse() async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('''SELECT
          s.*, 
          n.department, 
          n.certification
        FROM staff s
        INNER JOIN nurses n ON s.id = n.staff_id
        WHERE s.staff_type = 'nurse'
        ORDER BY s.last_name, s.first_name;''');

      return result.map((row) => Nurse.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching nurses: $error');
      return [];
    }
  }

  Future<bool> updateNurseField(String staffId, String fieldName, String newValue) async {
    try {
      final db = await DatabaseHelper().database;

      String columnName;
      switch (fieldName) {
        case 'department':
          columnName = 'department';
          break;
        case 'certification':
          columnName = 'certification';
          break;
        default:
          print('Error: Unknown nurse field name $fieldName');
          return false;
      }

      db.execute('UPDATE nurses SET $columnName = ? WHERE staff_id = ?', [
        newValue,
        staffId,
      ]);

      print('Nurse $fieldName updated successfully');
      return true;
    } catch (error) {
      print('Error updating nurse field: $error');
      return false;
    }
  }

  Future<Nurse?> getNurseByStaffId(String staffId) async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select(
        '''SELECT
          s.*, 
          n.department, 
          n.certification
        FROM staff s
        INNER JOIN nurses n ON s.id = n.staff_id
        WHERE s.id = ? AND s.staff_type = 'nurse';''',
        [staffId],
      );

      if (result.isNotEmpty) {
        return Nurse.fromMap(result.first);
      }
      return null;
    } catch (error) {
      print('Error fetching nurse by staff ID: $error');
      return null;
    }
  }
}
