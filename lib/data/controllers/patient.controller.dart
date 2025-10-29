import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';
import 'package:hospital_management_system/domain/patient.dart';

class PatientController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertPatient(Patient patient) async {
    try {
      final db = await _dbHelper.database;
      db.execute('''
        INSERT INTO patients (name, age, gender, nationality, commune, district, city, room_id, bed_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''', [
        patient.name,
        patient.age,
        patient.gender,
        patient.nationality,
        patient.commune,
        patient.district,
        patient.city,
        patient.roomId,
        patient.bedId,
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

  /// Allocate a bed based on chosen room type
  ///
  /// [roomTypeName] e.g. "VIP", "Private", "Shared"
  /// Returns true if successful, false if no bed available
  Future<bool> allocateBedToPatient(Patient patient, String roomTypeName) async {
    try {
      final db = await _dbHelper.database;

      // Find the chosen room type
      final roomTypeResult = db.select(
        'SELECT * FROM room_types WHERE LOWER(name) = LOWER(?);',
        [roomTypeName],
      );

      if (roomTypeResult.isEmpty) {
        print('\nRoom type "$roomTypeName" does not exist.');
        return false;
      }

      final roomType = RoomType.fromMap(roomTypeResult.first);

      // Find a room of that type that has a free bed
      final roomResult = db.select('''
        SELECT r.id AS room_id
        FROM rooms r
        JOIN room_types rt ON r.room_type_id = rt.id
        WHERE rt.id = ?;
      ''', [roomType.id]);

      if (roomResult.isEmpty) {
        print('\nNo room found for type "${roomType.name}".');
        return false;
      }

      // Loop through rooms to find one with an available bed
      for (final row in roomResult) {
        final roomId = row['room_id'] as int;

        // Find a free bed in that room
        final bedResult = db.select(
          'SELECT * FROM beds WHERE room_id = ? AND is_occupied = 0 LIMIT 1;',
          [roomId],
        );

        if (bedResult.isNotEmpty) {
          final bed = Bed.fromMap(bedResult.first);

          // Allocate this bed to the patient
          db.execute('''
            UPDATE beds SET is_occupied = 1 WHERE id = ?;
          ''', [bed.id]);

          db.execute('''
            UPDATE patients SET room_id = ?, bed_id = ? WHERE id = ?;
          ''', [roomId, bed.id, patient.id]);

          print('\n\t\t\t\tPatient "${patient.name}" assigned to:');
          print('\t\t\t\tRoom Type: ${roomType.name}');
          print('\t\t\t\tRoom ID: $roomId');
          print('\t\t\t\tBed ID: ${bed.id}\n');

          // Optional: check if all beds are full to mark room as occupied
          final remainingBeds = db.select(
            'SELECT * FROM beds WHERE room_id = ? AND is_occupied = 0;',
            [roomId],
          );

          if (remainingBeds.isEmpty) {
            db.execute('UPDATE rooms SET is_occupied = 1 WHERE id = ?;', [roomId]);
          }

          return true;
        }
      }
      // If no free bed found in any room
      print('\nNo available bed found for room type "${roomType.name}".');
      return false;
    } catch (error) {
      print("Error: $error");
      return false;
    } 
  } 
}