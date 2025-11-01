import 'dart:io';

import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/controllers/room_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';

class RoomConsole {
  final RoomController _roomController = RoomController();

  Future<void> viewRoom() async {
    List<Room> rooms = await _roomController.getAllRooms();

    clearScreen();

    print("\n\t\t\t\tRoom List\n");

    if (rooms.isEmpty) {
      print('\t\t\t\tNo room found.');
      pressEnterToContinue();
      return;
    }

    List<List<String>> rows = rooms
        .map(
          (r) => [
            (r.roomId ?? '-').toString(),
            (r.roomTypeId ?? '-').toString(),
            r.capacity.toString(),
            (r.isOccupied == 1 ? 'Occupied' : 'Available'),
            (r.departmentId ?? '-').toString(),
          ],
        )
        .toList();

    printTable(
      headers: [
        'Room ID',
        'Room Type ID',
        'Capacity',
        'Status',
        'Department ID',
      ],
      rows: rows,
    );

    pressEnterToContinue();
  }

  Future<void> createRoomView() async {
    clearScreen();
    print("\n\t\t\t\t--- Create New Room ---");

    // Show available room types (if table exists)
    final db = await DatabaseHelper().database;
    final types = db.select('SELECT id, name FROM room_types;');

    if (types.isEmpty) {
      print("\n\t\t\t\tNo room types found. Please create room types first.");
      return;
    }

    print("\n\t\t\t\tAvailable Room Types:");
    for (var t in types) {
      print("\t\t\t\t${t['id']}. ${t['name']}");
    }

    stdout.write("\n\t\t\t\tEnter Room Type ID: ");
    int roomTypeId = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    stdout.write("\t\t\t\tEnter Capacity: ");
    int capacity = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

    stdout.write("\t\t\t\tEnter Department ID (optional, 0 = none): ");
    int departmentId = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    final room = Room(
      roomNumber: null,
      roomTypeId: roomTypeId,
      capacity: capacity,
      departmentId: departmentId == 0 ? null : departmentId,
      isOccupied: false,
    );

    final result = await _roomController.insertRoom(room);
    if (result > 0) {
      print("\n\t\t\t\tRoom created successfully (ID: $result)");
      pressEnterToContinue();
    } else {
      print("\n\t\t\t\tFailed to create room.");
      pressEnterToContinue();
    }
  }

  Future<void> updateRoomView() async {
    try {
      clearScreen();
      print("\n\t\t\t\t--- Update Room ---");

      final rooms = await _roomController.getAllRooms();

      if (rooms.isEmpty) {
        print("\n\t\t\t\tNo rooms available to update.");
        return;
      }

      // Display existing rooms
      print("\n\t\t\t\tAvailable Rooms:");
      for (var r in rooms) {
        final status = r.isOccupied ? '[X]' : '[ ]';
        print(
          "\t\t\t\tRoom ${r.roomId} | Type ID: ${r.roomTypeId} | Capacity: ${r.capacity} | Status: $status",
        );
      }

      stdout.write("\n\t\t\t\tEnter Room ID to update: ");
      int roomId = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      final targetRoom = rooms.firstWhere(
        (r) => r.roomId == roomId,
        orElse: () => throw Exception("Room not found"),
      );

      stdout.write("\t\t\t\tEnter new Capacity: ");
      int capacity =
          int.tryParse(stdin.readLineSync() ?? '') ?? targetRoom.capacity;

      stdout.write("\t\t\t\tEnter new Department ID (optional): ");
      int departmentId =
          int.tryParse(stdin.readLineSync() ?? '') ??
          (targetRoom.departmentId ?? 0);

      final updatedRoom = Room(
        roomNumber: targetRoom.roomId,
        roomTypeId: targetRoom.roomTypeId,
        capacity: capacity,
        departmentId: departmentId == 0
            ? targetRoom.departmentId
            : departmentId,
        isOccupied: targetRoom.isOccupied,
      );

      await _roomController.updateRoom(updatedRoom);
      print("\n\t\t\t\tRoom updated successfully!");
      pressEnterToContinue();
    } catch (e) {
      print("\n\t\t\t\tError: ${e.toString()}");
      print("\n\t\t\t\tReturning to menu...");
      pressEnterToContinue();
    }
  }

  // Delete room
  Future<void> deleteRoomView() async {
    clearScreen();
    print("\n\t\t\t\t--- Delete Room ---");
    stdout.write("\n\t\t\t\tEnter Room ID to delete: ");
    int roomId = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    stdout.write(
      "\n\t\t\t\tAre you sure you want to delete room number $roomId? (y/n) ",
    );
    String confirm = stdin.readLineSync() ?? '';

    if (confirm.toLowerCase() == 'y') {
      await _roomController.deleteRoom(roomId);
      print("\n\t\t\t\tRoom deleted successfully!");
      pressEnterToContinue();
    } else {
      print("\n\t\t\t\tRoom deleted unsuccessfully!");
      pressEnterToContinue();
    }
  }

  Future<void> start() async {
    bool inRoomMenu = true;

    while (inRoomMenu) {
      clearScreen();
      print("\n\n\t\t\t\t=============================================\n");
      print("\t\t\t\t\tROOM MANAGEMENT\t\n");
      print("\t\t\t\t\t1. View Room");
      print("\t\t\t\t\t2. Create Room");
      print("\t\t\t\t\t3. Update Room");
      print("\t\t\t\t\t4. Delete Room");
      print("\t\t\t\t\t0. Go Back");
      print("\n\t\t\t\t=============================================\n");

      stdout.write("\t\t\t\tEnter your choice: ");
      String? input = stdin.readLineSync();

      int? choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          await viewRoom();
          break;
        case 2:
          await createRoomView();
          break;
        case 3:
          await updateRoomView();
          break;
        case 4:
          await deleteRoomView();
          break;
        case 0:
          inRoomMenu = false;
          break;
        default:
          print("Invalid choice, Please try again");
          continue;
      }
    }
  }
}
