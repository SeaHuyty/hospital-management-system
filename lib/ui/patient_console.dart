import 'dart:io';
import 'package:hospital_management_system/data/controllers/patient.controller.dart';
import 'package:hospital_management_system/data/controllers/room_controller.dart';
import 'package:hospital_management_system/domain/patient.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';
import 'package:hospital_management_system/ui/hospital_console.dart';

class PatientConsole {
  final PatientController _patientController = PatientController();
  final HospitalConsole _hospitalConsole = HospitalConsole();
  final RoomController _roomController = RoomController();

  Future<void> viewPatient() async {
    List<Patient> patients = await _patientController.getAllPatients();

    if (patients.isEmpty) {
      print('\t\t\t\tNo patients found.');
      pressEnterToContinue();
      return;
    }

    // Prepare rows
    List<List<String>> rows = patients
        .map(
          (p) => [
            p.id.toString(),
            p.name,
            p.age.toString(),
            p.gender,
            p.nationality,
            p.roomId.toString(),
            p.bedId.toString(),
          ],
        )
        .toList();

    printTable(
      headers: [
        'ID',
        'Name',
        'Age',
        'Gender',
        'Nationality',
        'Room ID',
        'Bed ID',
      ],
      rows: rows,
    );
    pressEnterToContinue();
  }

  Future<void> allocateBed() async {
    stdout.write("\t\t\t\tEnter patient name: ");
    String name = stdin.readLineSync() ?? '';
    stdout.write("\t\t\t\tEnter age: ");
    int age = int.tryParse(stdin.readLineSync() ?? '') ?? 1;
    stdout.write("\t\t\t\tEnter gender: ");
    String gender = stdin.readLineSync() ?? '';
    stdout.write("\t\t\t\tEnter nationality: ");
    String nationality = stdin.readLineSync() ?? '';
    print("\t\t\t\tEnter address: ");
    stdout.write("\t\t\t\tEnter commune: ");
    String commune = stdin.readLineSync() ?? '';
    stdout.write("\t\t\t\tEnter district: ");
    String district = stdin.readLineSync() ?? '';
    stdout.write("\t\t\t\tEnter city: ");
    String city = stdin.readLineSync() ?? '';
    // Choose room type
    print("\n\t\t\t\tChoose room type:");
    print("\t\t\t\t1. Shared Room");
    print("\t\t\t\t2. Private Room");
    print("\t\t\t\t3. VIP Room");
    stdout.write("\t\t\t\tEnter your choice: ");
    int choice = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

    String roomTypeName;
    switch (choice) {
      case 2:
        roomTypeName = 'Private';
        break;
      case 3:
        roomTypeName = 'VIP';
        break;
      default:
        roomTypeName = 'Shared';
    }

    // Fetch available rooms for that type
    final availableRooms = await _roomController.getAvailableRoomsByType(
      roomTypeName,
    );

    if (availableRooms.isEmpty) {
      print("\t\t\t\tNo available rooms for $roomTypeName type.");
      return;
    }

    print("\n\t\t\t\tAvailable Rooms for $roomTypeName:");
    for (var room in availableRooms) {
      print("\t\t\t\tRoom ID: ${room.roomId}");
      if (roomTypeName.toLowerCase() == 'shared') {
        final beds = await _roomController.getBedsByRoom(room.roomId!);
        String bedStatus = beds
            .map((b) => b.isOccupied ? '[X]' : '[ ]')
            .join(' ');
        print("\t\t\t\tBeds: $bedStatus");
      }
    }

    // Choose room
    stdout.write("\n\t\t\t\tEnter Room ID to assign: ");
    int roomId = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

    int? bedId;

    // If shared room → select bed
    if (roomTypeName.toLowerCase() == 'shared') {
      final beds = await _roomController.getBedsByRoom(roomId);
      final availableBeds = beds.where((b) => !b.isOccupied).toList();

      if (availableBeds.isEmpty) {
        print("\t\t\t\tNo available beds in this room.");
        return;
      }

      print("\n\t\t\t\tAvailable Beds:");
      for (var bed in availableBeds) {
        print("\t\t\t\tBed ID: ${bed.id}");
      }

      stdout.write("\t\t\t\tEnter Bed ID to assign: ");
      bedId = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
    } else {
      // Private/VIP just mark the room as occupied
      await _roomController.setRoomOccupied(roomId, true);
      bedId = null;
    }

    // Create Patient Object
    Patient patient = Patient(
      name: name,
      age: age,
      gender: gender,
      nationality: nationality,
      commune: commune,
      district: district,
      city: city,
      roomId: roomId,
      bedId: bedId,
    );

    // Insert into DB (don't await here; insertPatient may be synchronous)
    await _patientController.insertPatient(patient);
    print('\n\t\t\t\tPatient inserted successfully!\n');

    final success = await _patientController.allocateBedToPatient(
      patient,
      roomTypeName,
    );

    if (success) {
      print("\t\t\t\tBed allocated successfully!");
    } else {
      print("\t\t\t\tNo available room/bed found for this room type.");
    }
  }

  Future<void> start() async {
    clearScreen();
    int? choice;

    print("\n\n\t\t\t\t=============================================\n");
    print("\t\t\t\t\tPATIENT AND ROOM MANAGEMENT\t\n");
    print("\t\t\t\t\t1. View Patients");
    print("\t\t\t\t\t2. Allocate Bed");
    print("\t\t\t\t\t0. Exit program");
    print("\n\t\t\t\t=============================================\n");

    stdout.write("\t\t\t\tEnter your choice: ");
    String? input = stdin.readLineSync();

    choice = int.tryParse(input ?? '');

    switch (choice) {
      case 1:
        await viewPatient();
        break;
      case 2:
        await allocateBed();
        break;
      case 0:
        _hospitalConsole.start();
        break;
      default:
        print("Invalid choice, Please try again");
        break;
    }
  }
}
