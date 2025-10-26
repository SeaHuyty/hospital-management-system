import 'dart:io';
import 'package:hospital_management_system/data/controllers/doctor.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';

Future<void> staffConsole() async {
  int? option;

  do {
    clearScreen();
    print("=== STAFF MANAGEMENT ===");
    print('1. View All Doctors');
    print('2. View All Staff');
    print('3. Add New Staff');
    print('4. Edit Staff');
    print('0. Back to Main Menu');
    print('=' * 25);
    stdout.write('=> Select an option: ');
    stdout.flush(); // Ensure prompt is displayed

    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');

    switch (option) {
      case 1:
        await viewAllDoctors();
        break;

      case 2:
        print('View all staff functionality coming soon...');
        pressEnterToContinue();
        break;

      case 3:
        print('Add new staff functionality coming soon...');
        pressEnterToContinue();
        break;

      case 4:
        print('Edit staff functionality coming soon...');
        pressEnterToContinue();
        break;

      case 0:
        print('Returning to main menu...');
        break;

      default:
        print('Invalid option! Please try again.');
        pressEnterToContinue();
        break;
    }
  } while (option != 0);
}

Future<void> viewAllDoctors() async {
  try {
    // Clear screen for better presentation
    clearScreen();
    print("=== VIEW ALL DOCTORS ===");

    // Small delay to ensure any previous operations are complete
    await Future.delayed(Duration(milliseconds: 200));

    DoctorControllers doctorController = DoctorControllers();
    print('\nRetrieving all doctors...');
    List<Doctor> doctors = await doctorController.getAllDoctors();

    if (doctors.isEmpty) {
      print('No doctors found in the database.');
    } else {
      print('Found ${doctors.length} doctor(s):');
      for (int i = 0; i < doctors.length; i++) {
        Doctor doctor = doctors[i];
        print('\n--- Doctor ${i + 1} ---');
        print('ID: ${doctor.id}');
        print('Name: Dr. ${doctor.firstName} ${doctor.lastName}');
        print('Specialization: ${doctor.specialization}');
        print('License: ${doctor.licenseNumber}');
        print('Phone: ${doctor.phone}');
        print('Salary: \$${doctor.salary}');
        print('Status: ${doctor.employmentStatus}');
      }
    }
  } catch (error) {
    print('Error retrieving doctors: $error');
  }
  pressEnterToContinue();
}
