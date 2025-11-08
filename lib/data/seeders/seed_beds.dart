import 'package:hospital_management_system/domain/controllers/room/bed_controller.dart';
import 'package:hospital_management_system/domain/controllers/room/room_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

Future<void> seedBeds() async {
  final RoomController roomController = RoomController();
  final BedController bedController = BedController();

  final sharedRooms = await roomController.getRoomsByType('Shared');

  for (var room in sharedRooms) {
    final existingBeds = await roomController.getBedsByRoom(room.roomId!);
    if (existingBeds.isNotEmpty) {
      print('Room ${room.roomId} already has beds, skipping...');
      continue;
    }

    // Create beds according to room capacity
    for (int i = 1; i <= room.capacity; i++) {
      Bed bed = Bed(roomId: room.roomId, isOccupied: false);

      await bedController.insertBed(bed);
      print('Inserted bed $i for Room ${room.roomId}');
    }
  }

  print('Bed seeding completed!');
}
