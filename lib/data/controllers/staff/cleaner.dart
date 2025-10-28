import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/data/config/database.dart';

class CleanerControllers {
  Future<void> insertCleaner(Cleaner cleaner) async {
    final db = await DatabaseHelper().database;
    StaffControllers staffController = StaffControllers();

    int staffId = await staffController.insertBaseStaff(cleaner);
    if (staffId == -1) {
      print('Error inserting cleaner');
      return;
    }

    try {
      db.execute(
        '''
        INSERT INTO cleaners (
          staff_id,
          title,
          assigned_department,
          assigned_area
        ) VALUES (?, ?, ?, ?)
      ''',
        [
          staffId,
          cleaner.title,
          cleaner.assignedDepartment,
          cleaner.assignedArea,
        ],
      );
    } catch (error) {
      print('Error inserting cleaner details: $error');
    }
  }

  Future<List<Cleaner>> getAllCleaners() async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select('''SELECT
          s.*, 
          c.title, 
          c.assigned_department, 
          c.assigned_area
        FROM staff s
        INNER JOIN cleaners c ON s.id = c.staff_id
        WHERE s.staff_type = 'cleaner'
        ORDER BY s.last_name, s.first_name;''');

      return result.map((row) => Cleaner.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching cleaners: $error');
      return [];
    }
  }
}
