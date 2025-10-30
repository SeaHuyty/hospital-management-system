import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

class BedController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertBed(Bed bed) async {
    try {
      final db = await _dbHelper.database;

      db.execute('''
        INSERT INTO beds (room_id, is_occupied)
        VALUES (?, ?)
      ''', [bed.roomId, bed.isOccupied ? 1 : 0]);

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];
    } catch (error) {
      print("Error inserting bed: $error");
      return -1;
    }
  }
}