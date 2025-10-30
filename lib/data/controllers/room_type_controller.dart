import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

class RoomTypeController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertRoomType(RoomType roomType) async {
    try {
      final db = await _dbHelper.database;

      db.execute('''
        INSERT INTO room_types (name, price, description)
        VALUES (?, ?, ?)
      ''', [roomType.name, roomType.price, roomType.description]);

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];
    } catch (error) {
      print("Error inserting room type: $error");
      return -1;
    }
  }
}