import 'dart:io';
import 'package:hospital_management_system/data/controllers/patient.controller.dart';
import 'package:hospital_management_system/domain/patient.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';
import 'package:hospital_management_system/ui/hospital_console.dart';

class PatientConsole {
  final PatientController _patientController = PatientController();
  final HospitalConsole _hospitalConsole = HospitalConsole();

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
          ],
        )
        .toList();

    printTable(
      headers: ['ID', 'Name', 'Age', 'Gender', 'Nationality', 'Room ID'],
      rows: rows,
    );
    pressEnterToContinue();
  }

  void allocateBed() {
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
    stdout.write('\t\t\t\tEnter room ID: ');
    int roomId = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

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
    );

    // Insert into DB (don't await here; insertPatient may be synchronous)
    _patientController.insertPatient(patient);
    print('Patient inserted successfully!\n');
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
        allocateBed();
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
