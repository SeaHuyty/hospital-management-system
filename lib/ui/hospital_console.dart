import 'dart:io';
import 'package:hospital_management_system/domain/staff.dart';

import './staff_console.dart';
import './auth/authentication.dart';

class HospitalConsole {
  Future<void> start() async {
    Administrator? administrator = await authentication();

    if (administrator == null) {
      print('Invalid Credential');
      exit(0);
    }

    int? choice;
    do {
      print("\n\n\t\t\t\t=============================================\n");
      print("\t\t\t\t\tHOSPITAL MANAGEMENT SYSTEM\t\n");
      print("\t\t\t\t\t1. Staff");
      print("\t\t\t\t\t2. Room");
      print("\t\t\t\t\t0. Exit program");
      print("\n\t\t\t\t=============================================\n");

      stdout.write("\t\t\t\tEnter your choice: ");
      String? input = stdin.readLineSync();

      // Try parsing the input
      choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          staffConsole();
          break;
        case 2:
          //
          break;
        case 0:
          //
          break;
        default:
          print("\n\t\t\t\tInvalid choice! Please try again.");
          continue;
      }
    } while (choice != 0);
  }
}
