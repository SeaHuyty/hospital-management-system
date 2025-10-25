import 'dart:io';
import 'package:hospital_management_system/data/controllers/patient.controller.dart';
import 'package:hospital_management_system/domain/patient.dart';

class PatientConsole {
  final PatientController _patientController = PatientController();

  void start() async {
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
      roomId: roomId
    );

    // Insert into DB
    _patientController.insertPatient(patient);
    print('Patient inserted successfully!\n');

    // Read all patients
    List<Patient> patients = await _patientController.getAllPatients();
    print('All patients:');
    for (var p in patients) {
      print('${p.id}: ${p.name}, ${p.age} years old, Room ${p.roomId}');
    }
  }
}
