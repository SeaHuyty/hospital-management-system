import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/patient.dart';

class PatientController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertPatient(Patient patient) async {
    try {
      final db = await _dbHelper.database;
      db.execute('''
        INSERT INTO patients (name, age, gender, nationality, commune, district, city, room_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''', [
        patient.name,
        patient.age,
        patient.gender,
        patient.nationality,
        patient.commune,
        patient.district,
        patient.city,
        patient.roomId,
      ]);

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];

    } catch(error) {
      print("Error inserting patient: $error");
      return -1;
    }
  }

  Future<List<Patient>> getAllPatients() async {
    try {
      final db = await _dbHelper.database;
      final result = db.select('SELECT * FROM patients;');

      return result.map((row) => Patient.fromMap(row)).toList();
    } catch(error) {
      print("Error fetching patients: $error");
      return [];
    }
  }
}