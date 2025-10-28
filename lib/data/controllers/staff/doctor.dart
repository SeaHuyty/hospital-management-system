import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';

class DoctorControllers {
  Future<void> insertDoctor(Doctor doctor) async {
    final db = await DatabaseHelper().database;
    StaffControllers staffController = StaffControllers();

    int staffId = await staffController.insertBaseStaff(doctor);
    if (staffId == -1) {
      print('Error inserting doctor');
      return;
    }

    try {
      db.execute(
        '''
        INSERT INTO doctors (
          staff_id,
          specialization,
          license_number,
          qualification
        ) VALUES (?, ?, ?, ?)
      ''',
        [
          staffId,
          doctor.specialization,
          doctor.licenseNumber,
          doctor.qualification,
        ],
      );
    } catch (error) {
      print('Error inserting doctor details: $error');
    }
  }

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final db = await DatabaseHelper().database;
      final result = db.select(
        '''SELECT
          s.*, 
          d.specialization, 
          d.license_number, 
          d.qualification
        FROM staff s
        INNER JOIN doctors d ON s.id = d.staff_id
        WHERE s.staff_type = 'doctor'
        ORDER BY s.last_name, s.first_name;''',
      );

      return result.map((row) => Doctor.fromMap(row)).toList();
    } catch (error) {
      print('Error fetching doctors: $error');
      return [];
    }
  }
}
