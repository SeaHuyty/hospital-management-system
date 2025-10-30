import 'dart:io';
import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';

Future<void> updateStaffMenu() async {
  clearScreen();
  print("=== UPDATE STAFF ===");

  // Step 1: Get Staff ID
  stdout.write('Enter Staff ID to update: ');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('❌ Invalid input! Staff ID cannot be empty.');
    return;
  }

  String staffId = input.trim();

  try {
    print('\nSearching for staff with ID: $staffId...');

    StaffControllers staffController = StaffControllers();
    Staff? staff = await staffController.searchStaffById(staffId);

    if (staff == null) {
      print('❌ No staff found with ID: $staffId');
      print('Please check the ID and try again.');
      return;
    }

    // Step 2: Display current staff information
    print('✅ Staff found!\n');
    displayStaffSummary(staff);

    // Step 3: Confirm this is the correct staff
    print('\nIs this the staff member you want to update?');
    stdout.write('Enter (y/n): ');
    String? confirm = stdin.readLineSync();

    if (confirm?.toLowerCase() != 'y' && confirm?.toLowerCase() != 'yes') {
      print('Update cancelled.');
      return;
    }

    // Step 4: Show update menu based on staff type
    await showUpdateFieldsMenu(staff);
  } catch (error) {
    print('❌ Error occurred while searching for staff: $error');
  }
}

void displayStaffSummary(Staff staff) {
  List<String> headers = ['Field', 'Current Value'];
  List<List<String>> rows = [
    ['ID', staff.id?.toString() ?? 'N/A'],
    ['Name', '${staff.firstName} ${staff.lastName}'],
    ['Staff Type', staff.staffType.toString().split('.').last],
    ['Phone', staff.phone],
    ['Email', staff.email ?? 'N/A'],
    ['Employment Status', staff.employmentStatus],
    ['Shift', staff.shift],
    ['Salary', '\$${staff.salary}'],
  ];
  printTable(headers: headers, rows: rows, tabs: 1);
}

Future<void> showUpdateFieldsMenu(Staff staff) async {
  int? option;

  do {
    clearScreen();
    print("=== UPDATE FIELDS - ${staff.firstName} ${staff.lastName} ===");
    print("Staff Type: ${staff.staffType.toString().split('.').last}");
    print('');

    // Base fields available for all staff types
    print('BASIC INFORMATION:');
    print('1. First Name (${staff.firstName})');
    print('2. Last Name (${staff.lastName})');
    print('3. Phone (${staff.phone})');
    print('4. Email (${staff.email ?? 'N/A'})');
    print('5. Address (${staff.address ?? 'N/A'})');
    print('6. Emergency Contact Name (${staff.emergencyContactName ?? 'N/A'})');
    print(
      '7. Emergency Contact Phone (${staff.emergencyContactPhone ?? 'N/A'})',
    );
    print('8. Employment Status (${staff.employmentStatus})');
    print('9. Shift (${staff.shift})');
    print('10. Salary (\$${staff.salary})');

    // Role-specific fields
    int nextOption = 11;
    switch (staff.staffType) {
      case StaffType.doctor:
        print('\nDOCTOR SPECIFIC:');
        print('$nextOption. Specialization');
        print('${nextOption + 1}. License Number');
        print('${nextOption + 2}. Qualification');
        nextOption += 3;
        break;
      case StaffType.nurse:
        print('\nNURSE SPECIFIC:');
        print('$nextOption. Department');
        print('${nextOption + 1}. Certification');
        nextOption += 2;
        break;
      case StaffType.security:
        print('\nSECURITY SPECIFIC:');
        print('$nextOption. Title');
        print('${nextOption + 1}. Assigned Area');
        nextOption += 2;
        break;
      case StaffType.cleaner:
        print('\nCLEANER SPECIFIC:');
        print('$nextOption. Title');
        print('${nextOption + 1}. Assigned Department');
        print('${nextOption + 2}. Assigned Area');
        nextOption += 3;
        break;
      case StaffType.administrator:
        print('\nADMINISTRATOR SPECIFIC:');
        print('$nextOption. Username');
        print('${nextOption + 1}. Password');
        print('${nextOption + 2}. Department');
        nextOption += 3;
        break;
    }

    print('\n0. Back to Staff Menu');
    print('=' * 40);
    stdout.write('=> Select field to update: ');

    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');

    switch (option) {
      case 1:
        await updateBasicField(
          staff,
          'firstName',
          'First Name',
          staff.firstName,
        );
        break;
      case 2:
        await updateBasicField(staff, 'lastName', 'Last Name', staff.lastName);
        break;
      case 3:
        await updateBasicField(staff, 'phone', 'Phone', staff.phone);
        break;
      case 4:
        await updateBasicField(staff, 'email', 'Email', staff.email ?? '');
        break;
      case 5:
        await updateBasicField(
          staff,
          'address',
          'Address',
          staff.address ?? '',
        );
        break;
      case 6:
        await updateBasicField(
          staff,
          'emergencyContactName',
          'Emergency Contact Name',
          staff.emergencyContactName ?? '',
        );
        break;
      case 7:
        await updateBasicField(
          staff,
          'emergencyContactPhone',
          'Emergency Contact Phone',
          staff.emergencyContactPhone ?? '',
        );
        break;
      case 8:
        await updateBasicField(
          staff,
          'employmentStatus',
          'Employment Status',
          staff.employmentStatus,
        );
        break;
      case 9:
        await updateBasicField(staff, 'shift', 'Shift', staff.shift);
        break;
      case 10:
        await updateSalaryField(staff);
        break;
      case 11:
      case 12:
      case 13:
        await updateRoleSpecificField(staff, option! - 11);
        break;
      case 0:
        print('Returning to staff menu...');
        break;
      default:
        print('❌ Invalid option! Please try again.');
        pressEnterToContinue();
        break;
    }
  } while (option != 0);
}

Future<void> updateBasicField(
  Staff staff,
  String fieldName,
  String displayName,
  String currentValue,
) async {
  print('\n=== UPDATE $displayName ===');
  print('Current value: $currentValue');
  stdout.write('Enter new $displayName (or press Enter to keep current): ');

  String? newValue = stdin.readLineSync()?.trim();

  if (newValue == null || newValue.isEmpty) {
    print('No changes made to $displayName.');
    pressEnterToContinue();
    return;
  }

  // Validate required fields
  if ((fieldName == 'firstName' ||
          fieldName == 'lastName' ||
          fieldName == 'phone' ||
          fieldName == 'shift') &&
      newValue.isEmpty) {
    print('❌ $displayName cannot be empty!');
    pressEnterToContinue();
    return;
  }

  // Show confirmation
  print('\nConfirm changes:');
  print('Field: $displayName');
  print('From: "$currentValue"');
  print('To: "$newValue"');
  stdout.write('Save changes? (y/n): ');

  String? confirm = stdin.readLineSync();
  if (confirm?.toLowerCase() == 'y' || confirm?.toLowerCase() == 'yes') {
    bool success = await updateStaffInDatabase(
      staff.id!.toString(),
      fieldName,
      newValue,
    );
    if (success) {
      print('✅ $displayName updated successfully!');
    } else {
      print('❌ Failed to update $displayName.');
    }
  } else {
    print('Changes cancelled.');
  }

  pressEnterToContinue();
}

Future<void> updateSalaryField(Staff staff) async {
  print('\n=== UPDATE SALARY ===');
  print('Current salary: \$${staff.salary}');
  stdout.write('Enter new salary amount (or press Enter to keep current): ');

  String? input = stdin.readLineSync()?.trim();

  if (input == null || input.isEmpty) {
    print('No changes made to salary.');
    pressEnterToContinue();
    return;
  }

  try {
    double newSalary = double.parse(input);
    if (newSalary <= 0) {
      print('❌ Salary must be positive!');
      pressEnterToContinue();
      return;
    }

    // Show confirmation
    print('\nConfirm changes:');
    print('Field: Salary');
    print('From: \$${staff.salary}');
    print('To: \$$newSalary');
    stdout.write('Save changes? (y/n): ');

    String? confirm = stdin.readLineSync();
    if (confirm?.toLowerCase() == 'y' || confirm?.toLowerCase() == 'yes') {
      bool success = await updateStaffInDatabase(
        staff.id!.toString(),
        'salary',
        newSalary.toString(),
      );
      if (success) {
        print('✅ Salary updated successfully!');
      } else {
        print('❌ Failed to update salary.');
      }
    } else {
      print('Changes cancelled.');
    }
  } catch (e) {
    print('❌ Invalid salary amount!');
  }

  pressEnterToContinue();
}

Future<void> updateRoleSpecificField(Staff staff, int fieldIndex) async {
  // This would need to be implemented with specific role controllers
  // For now, showing the concept
  print('\n=== UPDATE ROLE-SPECIFIC FIELD ===');
  print('Role-specific field updates will be implemented based on staff type.');
  print('Staff Type: ${staff.staffType}');
  print('Field Index: $fieldIndex');

  // TODO: Implement role-specific updates using:
  // - DoctorControllers for doctors
  // - NurseControllers for nurses
  // - SecurityControllers for security
  // - CleanerControllers for cleaners
  // - AdministratorControllers for administrators

  pressEnterToContinue();
}

Future<bool> updateStaffInDatabase(
  String staffId,
  String fieldName,
  String newValue,
) async {
  try {
    StaffControllers staffController = StaffControllers();
    return await staffController.updateStaffField(staffId, fieldName, newValue);
  } catch (error) {
    print('❌ Database error: $error');
    return false;
  }
}
