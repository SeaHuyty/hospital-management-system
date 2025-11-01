import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

class RoomController {
  Future<int> insertRoom(Room room) async {
    try {
      final db = await DatabaseHelper().database;

      // Validate that the room type exists
      final typeCheck = db.select('SELECT id FROM room_types WHERE id = ?;', [
        room.roomTypeId,
      ]);

      if (typeCheck.isEmpty) {
        print('Invalid room type ID: ${room.roomTypeId}');
        return -1;
      }

      db.execute(
        '''
      INSERT INTO rooms (room_type_id, capacity, department_id, is_occupied)
      VALUES (?, ?, ?, ?);
    ''',
        [
          room.roomTypeId,
          room.capacity,
          room.departmentId,
          room.isOccupied ? 1 : 0,
        ],
      );

      final result = db.select('SELECT last_insert_rowid() AS id;');
      final insertedId = result.first['id'] as int;

      return insertedId;
    } catch (error) {
      print('Error inserting room: $error');
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

  Future<List<Room>> getRoomsByType(String roomTypeName) async {
    final db = await DatabaseHelper().database;
    final rooms = db.select(
      '''
    SELECT r.* FROM rooms r
    JOIN room_types rt ON r.room_type_id = rt.id
    WHERE rt.name = ?
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
}
