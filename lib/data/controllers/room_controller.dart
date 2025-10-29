import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

class RoomController {
  Future<int> insertRoom(Room room) async {
    try {
      final db = await DatabaseHelper().database;
      final stmt = db.prepare('''
      INSERT INTO rooms (room_type_id, capacity, department_id, is_occupied)
        VALUES (?, ?, ?, ?)
      ''');
      stmt.execute([
        room.roomTypeId,
        room.capacity,
        room.departmentId,
        room.isOccupied ? 1 : 0,
      ]);
      stmt.dispose();

      final result = db.select('SELECT last_insert_rowid() as id;');
      return result.first['id'];
    } catch (error) {
      print("Error inserting room: $error");
      return -1;
    }
  }

  Future<List<Room>> getAllRooms() async {
    final db = await DatabaseHelper().database;
    final result = db.select('SELECT * FROM rooms;');
    return result.map((row) => Room.fromMap(row)).toList();
  }

  Future<void> updateRoom(Room room) async {
    final db = await DatabaseHelper().database;
    db.execute(
      '''
      UPDATE rooms 
      SET room_type_id = ?, 
          capacity = ?, 
          department_id = ?, 
          is_occupied = ?
      WHERE id = ?
    ''',
      [
        room.roomTypeId,
        room.capacity,
        room.departmentId,
        room.isOccupied ? 1 : 0,
        room.roomId,
      ],
    );
  }

  Future<void> deleteRoom(int id) async {
    final db = await DatabaseHelper().database;
    db.execute('DELETE FROM rooms WHERE id = ?', [id]);
  }

  Future<void> markRoomOccupied(int roomId) async {
    final db = await DatabaseHelper().database;
    db.execute('UPDATE rooms SET is_occupied = 1 WHERE id = ?', [roomId]);
  }

  Future<List<Room>> getAvailableRoomsByType(String roomTypeName) async {
    final db = await DatabaseHelper().database;
    final rooms = db.select(
      '''
    SELECT r.* FROM rooms r
    JOIN room_types rt ON r.room_type_id = rt.id
    WHERE rt.name = ? AND r.is_occupied = 0
  ''',
      [roomTypeName],
    );
    return rooms.map((r) => Room.fromMap(r)).toList();
  }

  Future<List<Bed>> getBedsByRoom(int roomId) async {
    final db = await DatabaseHelper().database;
    final beds = db.select('SELECT * FROM beds WHERE room_id = ?', [roomId]);
    return beds.map((b) => Bed.fromMap(b)).toList();
  }

  Future<void> setRoomOccupied(int roomId, bool isOccupied) async {
    try {
      final db = await DatabaseHelper().database;

      db.execute(
        'UPDATE rooms SET is_occupied = ? WHERE id = ?',
        [isOccupied ? 1 : 0, roomId],
      );

      print('Room $roomId occupancy set to ${isOccupied ? "occupied" : "free"}');
    } catch (error) {
      print('Error updating room occupancy: $error');
    }
  }
}
