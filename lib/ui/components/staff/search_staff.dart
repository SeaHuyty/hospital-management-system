import 'dart:io';
import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';

Future<void> searchStaffById() async {
  clearScreen();
  print("=== SEARCH STAFF BY ID ===");

  stdout.write('Enter Staff ID: ');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('Invalid input! Staff ID cannot be empty.');
    return;
  }

  String staffId = input.trim();

  try {
    StaffControllers staffController = StaffControllers();
    Staff? staff = await staffController.searchStaffById(staffId);

    if (staff == null) {
      print('No staff found with ID: $staffId');
      print('Please check the ID and try again.');
      pressEnterToContinue();
    } else {
      // Display staff details in a table format
      List<String> headers = ['Field', 'Value'];

      List<List<String>> rows = [
        ['ID', staff.id?.toString() ?? 'N/A'],
        ['Full Name', '${staff.firstName} ${staff.lastName}'],
        ['Date of Birth', staff.dateOfBirth.toString().split(' ')[0]],
        ['Gender', staff.gender],
        ['Phone', staff.phone],
        ['Email', staff.email ?? 'N/A'],
        ['Address', staff.address ?? 'N/A'],
        ['Emergency Contact', staff.emergencyContactName ?? 'N/A'],
        ['Emergency Phone', staff.emergencyContactPhone ?? 'N/A'],
        ['Hire Date', staff.hireDate.toString().split(' ')[0]],
        ['Employment Status', staff.employmentStatus],
        ['Shift', staff.shift],
        ['Salary', '\$${staff.salary}'],
        ['Staff Type', staff.staffType.toString().split('.').last],
        ['Created At', staff.createdAt?.toString().split(' ')[0] ?? 'N/A'],
        ['Updated At', staff.updatedAt?.toString().split(' ')[0] ?? 'N/A'],
      ];

      printTable(headers: headers, rows: rows, tabs: 1);
      pressEnterToContinue();
    }
  } catch (error) {
    print('Error occurred while searching for staff: $error');
    print('Please try again or contact system administrator.');
    pressEnterToContinue();
  }
}

Future<void> searchStaffByIdWithMenu() async {
  await searchStaffById();
}
