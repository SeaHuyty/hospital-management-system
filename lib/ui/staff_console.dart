import 'dart:io';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/staff/view_all_staff.dart';

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
        print('View All Staff Based on Role functionality coming soon...');
        pressEnterToContinue();
        break;

      case 3:
        print('Edit Staff functionality coming soon...');
        pressEnterToContinue();
        break;

      case 4:
        print('Add New Staff functionality coming soon...');
        pressEnterToContinue();
        break;

      case 5:
        print('Edit Staff functionality coming soon...');
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