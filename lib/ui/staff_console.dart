import 'dart:io';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/staff/view_all_staff.dart';
import 'package:hospital_management_system/ui/components/staff/staff_view_role.dart';
import 'package:hospital_management_system/ui/components/staff/search_staff.dart';
import 'package:hospital_management_system/ui/components/staff/add_staff.dart';
import 'package:hospital_management_system/ui/components/staff/update_staff.dart';

Future<void> staffConsole() async {
  int? option;

  do {
    clearScreen();
    print("=== STAFF MANAGEMENT ===");
    print('1. View All Staff');
    print('2. View All Staff Based on Role');
    print('3. Search Staff By ID');
    print('4. Add New Staff');
    print('5. Edit Staff');
    print('\n0. Back to Main Menu');
    print('=' * 25);
    stdout.write('=> Select an option: ');
    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');

    switch (option) {
      case 1:
        await viewAllStaffs();
        pressEnterToContinue();
        break;

      case 2:
        await staffViewByRole();
        break;

      case 3:
        await searchStaffByIdWithMenu();
        break;

      case 4:
        await addNewStaffMenu();
        break;

      case 5:
        await updateStaffMenu();
        pressEnterToContinue();
        break;

      case 0:
        break;

      default:
        print('Invalid option! Please try again.');
        pressEnterToContinue();
        break;
    }
  } while (option != 0);
}
