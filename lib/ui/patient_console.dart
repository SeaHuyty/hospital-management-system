import 'dart:io';
import 'package:hospital_management_system/data/controllers/room/patient.controller.dart';
import 'package:hospital_management_system/data/controllers/room/room_controller.dart';
import 'package:hospital_management_system/domain/patient.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';

class PatientConsole {
  final PatientController _patientController = PatientController();
  final RoomController _roomController = RoomController();

  Future<void> viewPatient() async {
    List<Patient> patients = await _patientController.getAllPatients();

    clearScreen();

    print("\n\t\t\t\tPatient List\n");

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
    clearScreen();
    print("\n\t\t\t\tInput patient information");
    stdout.write("\n\t\t\t\tEnter patient name: ");
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
    stdout.write("\n\t\t\t\tEnter your choice: ");
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

    clearScreen();

    final rooms = await _roomController.getRoomsByType(roomTypeName);

    if (rooms.isEmpty) {
      print("\n\t\t\t\tNo rooms found for $roomTypeName type.");
      return;
    }

    print("\n\t\t\t\t[ ] = Available \t[X] = Occupied");
    print("\n\t\t\t\t$roomTypeName Room");

    final isShared = roomTypeName.toLowerCase() == 'shared';

    if (isShared) {
      final roomStatusRow = <String>[];

      for (var room in rooms) {
        final beds = await _roomController.getBedsByRoom(room.roomId!);
        final allBedsFull = beds.isNotEmpty && beds.every((b) => b.isOccupied);
        final status = allBedsFull ? '[X]' : '[ ]';
        roomStatusRow.add("${room.roomId}. $status");
      }
      print("\n\t\t\t\t${roomStatusRow.join('   ')}");
    } else {
      final roomStatusRow = rooms
          .map((room) => "${room.roomId}. ${room.isOccupied ? '[X]' : '[ ]'}")
          .join('   ');

      print("\n\t\t\t\t$roomStatusRow");
    }

    // Choose room
    stdout.write("\n\t\t\t\tEnter Room ID to assign: ");
    int roomId = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

    int? bedId;

    // Select bed
    if (isShared) {
      final beds = await _roomController.getBedsByRoom(roomId);
      final availableBeds = beds.where((b) => !b.isOccupied).toList();

      if (availableBeds.isEmpty) {
        print("\n\t\t\t\tNo available beds in this room.");
        return;
      }

      final bedStatus = beds
          .map((b) => "${b.id}. ${b.isOccupied ? '[X]' : '[ ]'}")
          .join('  ');

      print("\n\t\t\t\tBeds");
      print("\n\t\t\t\t$bedStatus");

      stdout.write("\n\t\t\t\tEnter Bed ID to assign: ");
      bedId = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
    } else {
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

    final success = await _patientController.allocateBedToPatient(
      patient,
      roomTypeName,
      roomId,
      bedId
    );

    if (success) {
      await _patientController.insertPatient(patient);
      print("\t\t\t\tBed allocated successfully!");
      pressEnterToContinue();
    } else {
      pressEnterToContinue();
    }
  }

  Future<void> start() async {
    bool inPatientMenu = true;

    while (inPatientMenu) {
      clearScreen();
      print("\n\n\t\t\t\t=============================================\n");
      print("\t\t\t\t\tPATIENT MANAGEMENT\t\n");
      print("\t\t\t\t\t1. View Patients");
      print("\t\t\t\t\t2. Allocate Bed");
      print("\t\t\t\t\t0. Go Back");
      print("\n\t\t\t\t=============================================\n");

      stdout.write("\t\t\t\tEnter your choice: ");
      String? input = stdin.readLineSync();

      int? choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          await viewPatient();
          break;
        case 2:
          await allocateBed();
          break;
        case 0:
          inPatientMenu = false;
          break;
        default:
          print("Invalid choice, Please try again");
          continue;
      }
    }
  }
}
