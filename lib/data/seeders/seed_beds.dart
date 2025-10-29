import 'package:hospital_management_system/data/controllers/bed_controller.dart';
import 'package:hospital_management_system/data/controllers/room_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

Future<void> seedBeds() async {
  final RoomController roomController = RoomController();
  final BedController bedController = BedController();

  // Get all shared rooms
  final sharedRooms = await roomController.getAvailableRoomsByType('Shared');

  for (var room in sharedRooms) {
    // Check existing beds for this room
    final existingBeds = await roomController.getBedsByRoom(room.roomId!);
    if (existingBeds.isNotEmpty) {
      print('Room ${room.roomId} already has beds, skipping...');
      continue;
    }

    // Create beds according to room capacity
    for (int i = 1; i <= room.capacity; i++) {
      Bed bed = Bed(
        roomId: room.roomId,
        isOccupied: false,
      );

      await bedController.insertBed(bed);
      print('Inserted bed $i for Room ${room.roomId}');
    }
  }

  print('Bed seeding completed!');
}