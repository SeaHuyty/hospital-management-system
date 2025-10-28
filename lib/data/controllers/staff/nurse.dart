import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';
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
}
