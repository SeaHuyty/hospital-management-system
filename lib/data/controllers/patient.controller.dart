import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';
import 'package:hospital_management_system/domain/patient.dart';

class PatientController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertPatient(Patient patient) async {
    try {
      final db = await _dbHelper.database;
      db.execute(
        '''
        INSERT INTO patients (name, age, gender, nationality, commune, district, city, room_id, bed_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          patient.name,
          patient.age,
          patient.gender,
          patient.nationality,
          patient.commune,
          patient.district,
          patient.city,
          patient.roomId,
          patient.bedId,
        ],
      );

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];
    } catch (error) {
      print("Error inserting patient: $error");
      return -1;
    }
  }

  Future<List<Patient>> getAllPatients() async {
    try {
      final db = await _dbHelper.database;
      final result = db.select('SELECT * FROM patients;');

      return result.map((row) => Patient.fromMap(row)).toList();
    } catch (error) {
      print("Error fetching patients: $error");
      return [];
    }
  }

  /// Allocate a bed based on chosen room type
  ///
  /// [roomTypeName] e.g. "VIP", "Private", "Shared"
  /// Returns true if successful, false if no bed available
  Future<bool> allocateBedToPatient(
    Patient patient,
    String roomTypeName,
    int roomId,
    int? bedId,
  ) async {
    try {
      final db = await _dbHelper.database;

      // Find the chosen room type
      final roomTypeResult = db.select(
        'SELECT * FROM room_types WHERE LOWER(name) = LOWER(?);',
        [roomTypeName],
      );

      if (roomTypeResult.isEmpty) {
        print('\n\t\t\t\tRoom type "$roomTypeName" does not exist.');
        return false;
      }

      final roomType = RoomType.fromMap(roomTypeResult.first);

      // Check if chosen room exists and belongs to this type
      final roomCheck = db.select(
        '''
      SELECT r.id, r.is_occupied 
      FROM rooms r
      WHERE r.id = ? AND r.room_type_id = ?;
    ''',
        [roomId, roomType.id],
      );

      if (roomCheck.isEmpty) {
        print('\n\t\t\t\tInvalid room ID or does not belong to type "$roomTypeName".');
        return false;
      }

      final roomData = roomCheck.first;
      final isRoomOccupied = (roomData['is_occupied'] == 1);

      // Handle Shared rooms (with beds)
      if (roomTypeName.toLowerCase() == 'shared') {
        if (bedId == null) {
          print('\n\t\t\t\tBed ID is required for shared rooms.');
          return false;
        }

        final bedCheck = db.select(
          '''
        SELECT * FROM beds 
        WHERE id = ? AND room_id = ?;
      ''',
          [bedId, roomId],
        );

        if (bedCheck.isEmpty) {
          print('\n\t\t\t\tInvalid bed ID for this room.');
          return false;
        }

        final bed = Bed.fromMap(bedCheck.first);

        if (bed.isOccupied) {
          print('\n\t\t\t\tSelected bed is already occupied.');
          return false;
        }

        // Assign the chosen bed
        db.execute('UPDATE beds SET is_occupied = 1 WHERE id = ?;', [bedId]);
        db.execute(
          'UPDATE patients SET room_id = ?, bed_id = ? WHERE id = ?;',
          [roomId, bedId, patient.id],
        );

        // Check if all beds are full to mark room occupied
        final remainingBeds = db.select(
          'SELECT * FROM beds WHERE room_id = ? AND is_occupied = 0;',
          [roomId],
        );
        if (remainingBeds.isEmpty) {
          db.execute('UPDATE rooms SET is_occupied = 1 WHERE id = ?;', [
            roomId,
          ]);
        }

        print('\n\t\t\t\tPatient "${patient.name}" assigned to:');
        print('\t\t\t\tRoom Type: ${roomType.name}');
        print('\t\t\t\tRoom ID: $roomId');
        print('\t\t\t\tBed ID: $bedId\n');

        return true;
      } else {
        // For Private/VIP rooms, we only need to check if selected room is occupied
        if (isRoomOccupied) {
          print("\n\t\t\t\tSelected room is already occupied.");
          return false;
        }

        // Mark room as occupied
        db.execute('UPDATE rooms SET is_occupied = 1 WHERE id = ?;', [roomId]);

        // Assign room to patient (no bed)
        db.execute(
          'UPDATE patients SET room_id = ?, bed_id = NULL WHERE id = ?;',
          [roomId, patient.id],
        );

        print('\n\t\t\t\tPatient "${patient.name}" assigned to:');
        print('\t\t\t\tRoom Type: ${roomType.name}');
        print('\t\t\t\tRoom ID: $roomId\n');

        return true;
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }
}
