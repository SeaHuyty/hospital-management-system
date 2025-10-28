import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';

class SecurityControllers {
  Future<void> insertSecurity(Security security) async {
    final db = await DatabaseHelper().database;
    StaffControllers staffController = StaffControllers();

    int staffId = await staffController.insertBaseStaff(security);
    if (staffId == -1) {
      print('Error inserting security staff');
      return;
    }

    try {
      db.execute(
        '''
        INSERT INTO security (
          staff_id,
          title,
          assigned_area
        ) VALUES (?, ?, ?)
      ''',
        [staffId, security.title, security.assignedArea],
      );
    } catch (error) {
      print('Error inserting security staff details: $error');
    }
  }

  Future<List<Security>> getAllSecurityStaff() async {
    try {
      final db = await DatabaseHelper().database;

      final result = db.select('''
        SELECT 
          s.*,
          ss.title,
          ss.assigned_area
        FROM 
          staff s
        JOIN 
          security_staff ss ON s.id = ss.staff_id
      ''');

      return result.map((row) => Security.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching security staff: $error');
      return [];
    }
  }
}
