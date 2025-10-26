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

  Future<List<Doctor>> getAllDoctors() async {
    List<Doctor> doctors = [];

    try {
      final db = await DatabaseHelper().database;

      final result = db.select('''
        SELECT 
          s.id,
          s.first_name,
          s.last_name,
          s.date_of_birth,
          s.gender,
          s.phone,
          s.email,
          s.address,
          s.emergency_contact_name,
          s.emergency_contact_phone,
          s.hire_date,
          s.employment_status,
          s.shift,
          s.salary,
          s.created_at,
          s.updated_at,
          d.specialization,
          d.license_number,
          d.qualification
        FROM staff s
        INNER JOIN doctors d ON s.id = d.staff_id
        WHERE s.staff_type = 'doctor'
        ORDER BY s.last_name, s.first_name
      ''');

      for (final row in result) {
        Doctor doctor = Doctor(
          id: row['id'] as int,
          firstName: row['first_name'] as String,
          lastName: row['last_name'] as String,
          dateOfBirth: DateTime.parse(row['date_of_birth'] as String),
          gender: row['gender'] as String,
          phone: row['phone'] as String,
          email: row['email'] as String?,
          address: row['address'] as String?,
          emergencyContactName: row['emergency_contact_name'] as String?,
          emergencyContactPhone: row['emergency_contact_phone'] as String?,
          hireDate: DateTime.parse(row['hire_date'] as String),
          employmentStatus: row['employment_status'] as String,
          shift: row['shift'] as String,
          salary: row['salary'] as double,
          createdAt: row['created_at'] != null
              ? DateTime.parse(row['created_at'] as String)
              : null,
          updatedAt: row['updated_at'] != null
              ? DateTime.parse(row['updated_at'] as String)
              : null,
          specialization: row['specialization'] as String,
          licenseNumber: row['license_number'] as String,
          qualification: row['qualification'] as String,
        );

        doctors.add(doctor);
      }
    } catch (error) {
      print('Error retrieving doctors: $error');
    }
    
    return doctors;
  }
}
