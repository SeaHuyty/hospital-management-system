import 'dart:io';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/patient_console.dart';
import 'package:hospital_management_system/ui/room_console.dart'; 
import 'package:hospital_management_system/ui/staff_console.dart';
import 'package:hospital_management_system/ui/auth/authentication.dart';

class HospitalConsole {
  Future<void> start() async {
    Administrator? administrator = await authentication();
    PatientConsole patientConsole = PatientConsole();
    RoomConsole roomConsole = RoomConsole();

    if (administrator == null) {
      print('Invalid Credential');
      exit(0);
    }

    int? choice;
    do {
      clearScreen();
      print("\n\n\t\t\t\t=============================================\n");
      print("\t\t\t\t\tHOSPITAL MANAGEMENT SYSTEM\t\n");
      print("\t\t\t\t\t1. Manange Staff");
      print("\t\t\t\t\t2. Manage Room");
      print("\t\t\t\t\t3. Manage Patient");
      print("\t\t\t\t\t0. Exit program");
      print("\n\t\t\t\t=============================================\n");

      stdout.write("\t\t\t\tEnter your choice: ");
      String? input = stdin.readLineSync();

      // Try parsing the input
      choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          await staffConsole();
          break;
        case 2:
          await roomConsole.start();
          break;
        case 3: 
          await patientConsole.start();
          break;
        case 0:
          Session.currentAdmin = null;
          print("\n\t\t\t\tExited Program\n");
          break;
        default:
          print("\n\t\t\t\tInvalid choice! Please try again.");
          pressEnterToContinue();
          continue;
      }
    } while (choice != 0);
  }
}