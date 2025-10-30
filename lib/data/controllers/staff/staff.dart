import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/staff.dart';

class StaffControllers {
  Future<int> insertBaseStaff(Staff staff) async {
    try {
      final db = await DatabaseHelper().database;

      final now = DateTime.now().toIso8601String();

      db.execute(
        '''
          INSERT INTO staff (
            first_name, 
            last_name, 
            date_of_birth, 
            gender,
            phone,
            email,
            address,
            emergency_contact_name,
            emergency_contact_phone,
            hire_date,
            employment_status,
            shift,
            salary,
            staff_type,
            created_at,
            updated_at
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          staff.firstName,
          staff.lastName,
          staff.dateOfBirth.toIso8601String(),
          staff.gender,
          staff.phone,
          staff.email,
          staff.address,
          staff.emergencyContactName,
          staff.emergencyContactPhone,
          staff.hireDate.toIso8601String(),
          staff.employmentStatus,
          staff.shift,
          staff.salary,
          staff.staffType.toString().split('.').last, // Convert enum to string
          now,
          now,
        ],
      );

      // Get the last inserted id
      final result = db.select('SELECT last_insert_rowid() as id');
      return result.first['id'] as int;
    } catch (error) {
      print('Error inserting base staff: $error');
      return -1;
    }
  }

  Future<List<Staff>> getAllStaff() async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('SELECT * FROM staff;');

      return result.map((row) => Staff.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching staff: $error');
      return [];
    }
  }

  Future<Staff?> searchStaffById(String id) async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('SELECT * FROM staff WHERE id = ?;', [id]);
      return Staff.fromMap(result.first);
    } catch (error) {
      print('Error fetching staff with id $id: $error');
      return null;
    }
  }

  Future<bool> updateStaffField(
    String staffId,
    String fieldName,
    String newValue,
  ) async {
    try {
      final db = await DatabaseHelper().database;
      final now = DateTime.now().toIso8601String();

      // Map field names to database column names
      String columnName;
      switch (fieldName) {
        case 'firstName':
          columnName = 'first_name';
          break;
        case 'lastName':
          columnName = 'last_name';
          break;
        case 'phone':
          columnName = 'phone';
          break;
        case 'email':
          columnName = 'email';
          break;
        case 'address':
          columnName = 'address';
          break;
        case 'emergencyContactName':
          columnName = 'emergency_contact_name';
          break;
        case 'emergencyContactPhone':
          columnName = 'emergency_contact_phone';
          break;
        case 'employmentStatus':
          columnName = 'employment_status';
          break;
        case 'shift':
          columnName = 'shift';
          break;
        case 'salary':
          columnName = 'salary';
          break;
        default:
          print('Error: Unknown field name $fieldName');
          return false;
      }

      db.execute(
        'UPDATE staff SET $columnName = ?, updated_at = ? WHERE id = ?',
        [newValue, now, staffId],
      );

      print('Staff field updated successfully');
      return true;
    } catch (error) {
      print('Error updating staff field: $error');
      return false;
    }
  }
}
