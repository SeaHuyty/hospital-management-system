import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/controllers/staff.dart';
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
}