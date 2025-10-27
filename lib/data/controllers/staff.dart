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
    // List<Staff> staffs = [];
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('SELECT * FROM staff;');

      return result.map((row) => Staff.fromMap(row)).toList();
      
      // for (final row in result) {
      //   Staff staff = Staff(
      //     id: row['id'],
      //     firstName: row['first_name'],
      //     lastName: row['last_name'],
      //     dateOfBirth: DateTime.parse(row['date_of_birth']),
      //     gender: row['gender'],
      //     phone: row['phone'],
      //     email: row['email'],
      //     address: row['address'],
      //     emergencyContactName: row['emergency_contact_name'],
      //     emergencyContactPhone: row['emergency_contact_phone'],
      //     hireDate: DateTime.parse(row['hire_date']),
      //     employmentStatus: row['employment_status'],
      //     shift: row['shift'],
      //     salary: row['salary'],
      //     staffType: StaffType.values.firstWhere(
      //         (e) => e.toString().split('.').last == row['staff_type']),
      //     createdAt: DateTime.parse(row['created_at']),
      //     updatedAt: DateTime.parse(row['updated_at']),
      //   );

      //   staffs.add(staff);
      // }
    } catch (error) {
      print('Error fetching staff: $error');
      return [];
    }

    // return staffs;
  }
}
