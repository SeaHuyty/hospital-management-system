import 'dart:io';
import 'package:hospital_management_system/domain/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/controllers/staff/doctor.dart';
import 'package:hospital_management_system/domain/controllers/staff/nurse.dart';
import 'package:hospital_management_system/domain/controllers/staff/security.dart';
import 'package:hospital_management_system/domain/controllers/staff/cleaner.dart';
import 'package:hospital_management_system/domain/controllers/staff/administrator.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';
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
      return;
    }

    displayStaffSummary(staff);

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
    print('Error occurred while searching for staff: $error');
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
    print('1. First Name');
    print('2. Last Name');
    print('3. Phone');
    print('4. Email');
    print('5. Address');
    print('6. Emergency Contact Name');
    print('7. Emergency Contact Phone');
    print('8. Employment Status');
    print('9. Shift');
    print('10. Salary');

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
        await updateBasicField(staff, 'firstName', 'First Name', staff.firstName);
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
        await updateBasicField(staff, 'address', 'Address', staff.address ?? '');
        break;
      case 6:
        await updateBasicField(staff, 'emergencyContactName', 'Emergency Contact Name', staff.emergencyContactName ?? '');
        break;
      case 7:
        await updateBasicField(staff, 'emergencyContactPhone', 'Emergency Contact Phone', staff.emergencyContactPhone ?? '');
        break;
      case 8:
        await updateBasicField(staff, 'employmentStatus', 'Employment Status', staff.employmentStatus);
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
        break;
      default:
        print('Invalid option! Please try again.');
        pressEnterToContinue();
        break;
    }
  } while (option != 0);
}

Future<void> updateBasicField(Staff staff, String fieldName, String displayName, String currentValue) async {
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
    print('$displayName cannot be empty!');
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
      print('$displayName updated successfully!');
    } else {
      print('Failed to update $displayName.');
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
      print('Salary must be positive!');
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
        print('Salary updated successfully!');
      } else {
        print('Failed to update salary.');
      }
    } else {
      print('Changes cancelled.');
    }
  } catch (e) {
    print('Invalid salary amount!');
  }

  pressEnterToContinue();
}

Future<void> updateRoleSpecificField(Staff staff, int fieldIndex) async {
  switch (staff.staffType) {
    case StaffType.doctor:
      await updateDoctorSpecificField(staff, fieldIndex);
      break;

    case StaffType.nurse:
      await updateNurseSpecificField(staff, fieldIndex);
      break;

    case StaffType.security:
      await updateSecuritySpecificField(staff, fieldIndex);
      break;

    case StaffType.cleaner:
      await updateCleanerSpecificField(staff, fieldIndex);
      break;

    case StaffType.administrator:
      await updateAdministratorSpecificField(staff, fieldIndex);
      break;
  }
}

Future<void> updateDoctorSpecificField(Staff staff, int fieldIndex) async {
  try {
    DoctorControllers doctorController = DoctorControllers();
    Doctor? doctor = await doctorController.getDoctorByStaffId(staff.id!.toString());

    if (doctor == null) {
      print('Doctor details not found!');
      pressEnterToContinue();
      return;
    }

    String fieldName;
    String displayName;
    String currentValue;

    switch (fieldIndex) {
      case 0: // Specialization
        fieldName = 'specialization';
        displayName = 'Specialization';
        currentValue = doctor.specialization;
        break;
      case 1: // License Number
        fieldName = 'licenseNumber';
        displayName = 'License Number';
        currentValue = doctor.licenseNumber;
        break;
      case 2: // Qualification
        fieldName = 'qualification';
        displayName = 'Qualification';
        currentValue = doctor.qualification;
        break;
      default:
        print('Invalid field index!');
        pressEnterToContinue();
        return;
    }

    await updateSpecializedField(staff, fieldName, displayName, currentValue, 'doctor');
  } catch (error) {
    print('Error fetching doctor details: $error');
    pressEnterToContinue();
  }
}

Future<void> updateNurseSpecificField(Staff staff, int fieldIndex) async {
  try {
    NurseControllers nurseController = NurseControllers();
    Nurse? nurse = await nurseController.getNurseByStaffId(staff.id!.toString());

    if (nurse == null) {
      print('Nurse details not found!');
      pressEnterToContinue();
      return;
    }

    String fieldName;
    String displayName;
    String currentValue;

    switch (fieldIndex) {
      case 0: // Department
        fieldName = 'department';
        displayName = 'Department';
        currentValue = nurse.department;
        break;
      case 1: // Certification
        fieldName = 'certification';
        displayName = 'Certification';
        currentValue = nurse.certification;
        break;
      default:
        print('Invalid field index!');
        pressEnterToContinue();
        return;
    }

    await updateSpecializedField(staff, fieldName, displayName, currentValue, 'nurse');
  } catch (error) {
    print('Error fetching nurse details: $error');
    pressEnterToContinue();
  }
}

Future<void> updateSecuritySpecificField(Staff staff, int fieldIndex) async {
  try {
    SecurityControllers securityController = SecurityControllers();
    Security? security = await securityController.getSecurityByStaffId(staff.id!.toString());

    if (security == null) {
      print('Security details not found!');
      pressEnterToContinue();
      return;
    }

    String fieldName;
    String displayName;
    String currentValue;

    switch (fieldIndex) {
      case 0: // Title
        fieldName = 'title';
        displayName = 'Title';
        currentValue = security.title;
        break;
      case 1: // Assigned Area
        fieldName = 'assignedArea';
        displayName = 'Assigned Area';
        currentValue = security.assignedArea;
        break;
      default:
        print('Invalid field index!');
        pressEnterToContinue();
        return;
    }

    await updateSpecializedField(staff, fieldName, displayName, currentValue, 'security');
  } catch (error) {
    print('Error fetching security details: $error');
    pressEnterToContinue();
  }
}

Future<void> updateCleanerSpecificField(Staff staff, int fieldIndex) async {
  try {
    CleanerControllers cleanerController = CleanerControllers();
    Cleaner? cleaner = await cleanerController.getCleanerByStaffId(staff.id!.toString());

    if (cleaner == null) {
      print('Cleaner details not found!');
      pressEnterToContinue();
      return;
    }

    String fieldName;
    String displayName;
    String currentValue;

    switch (fieldIndex) {
      case 0: // Title
        fieldName = 'title';
        displayName = 'Title';
        currentValue = cleaner.title;
        break;
      case 1: // Assigned Department
        fieldName = 'assignedDepartment';
        displayName = 'Assigned Department';
        currentValue = cleaner.assignedDepartment;
        break;
      case 2: // Assigned Area
        fieldName = 'assignedArea';
        displayName = 'Assigned Area';
        currentValue = cleaner.assignedArea;
        break;
      default:
        print('Invalid field index!');
        pressEnterToContinue();
        return;
    }

    await updateSpecializedField(staff, fieldName, displayName, currentValue, 'cleaner');
  } catch (error) {
    print('Error fetching cleaner details: $error');
    pressEnterToContinue();
  }
}

Future<void> updateAdministratorSpecificField(Staff staff, int fieldIndex) async {
  try {
    AdministratorControllers adminController = AdministratorControllers();
    Administrator? admin = await adminController.getAdministratorByStaffId(staff.id!.toString());

    if (admin == null) {
      print('Administrator details not found!');
      pressEnterToContinue();
      return;
    }

    String fieldName;
    String displayName;
    String currentValue;

    switch (fieldIndex) {
      case 0: // Username
        fieldName = 'username';
        displayName = 'Username';
        currentValue = admin.username;
        break;
      case 1: // Password
        fieldName = 'password';
        displayName = 'Password';
        currentValue = admin.password;
        break;
      case 2: // Department
        fieldName = 'department';
        displayName = 'Department';
        currentValue = admin.department;
        break;
      default:
        print('Invalid field index!');
        pressEnterToContinue();
        return;
    }

    await updateSpecializedField(staff, fieldName, displayName, currentValue, 'administrator');
  } catch (error) {
    print('Error fetching administrator details: $error');
    pressEnterToContinue();
  }
}

Future<void> updateSpecializedField(Staff staff, String fieldName, String displayName, String currentValue, String staffType) async {
  print('\n=== UPDATE $displayName ===');
  print('Current value: $currentValue');
  stdout.write('Enter new $displayName (or press Enter to keep current): ');

  String? newValue = stdin.readLineSync()?.trim();

  if (newValue == null || newValue.isEmpty) {
    print('No changes made to $displayName.');
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
    bool success = await updateSpecializedFieldInDatabase(staff.id!.toString(), fieldName, newValue, staffType);
    if (success) {
      print('$displayName updated successfully!');
    } else {
      print('Failed to update $displayName.');
    }
  } else {
    print('Changes cancelled.');
  }

  pressEnterToContinue();
}

Future<bool> updateSpecializedFieldInDatabase(String staffId, String fieldName, String newValue, String staffType) async {
  try {
    switch (staffType) {
      case 'doctor':
        DoctorControllers doctorController = DoctorControllers();
        return await doctorController.updateDoctorField(staffId, fieldName, newValue);

      case 'nurse':
        NurseControllers nurseController = NurseControllers();
        return await nurseController.updateNurseField(staffId, fieldName, newValue);

      case 'security':
        SecurityControllers securityController = SecurityControllers();
        return await securityController.updateSecurityField(staffId, fieldName, newValue);

      case 'cleaner':
        CleanerControllers cleanerController = CleanerControllers();
        return await cleanerController.updateCleanerField(staffId, fieldName, newValue);

      case 'administrator':
        AdministratorControllers adminController = AdministratorControllers();
        return await adminController.updateAdministratorField(staffId, fieldName, newValue);

      default:
        print('Unknown staff type: $staffType');
        return false;
    }
  } catch (error) {
    print('Database error: $error');
    return false;
  }
}

Future<bool> updateStaffInDatabase(String staffId, String fieldName, String newValue) async {
  try {
    StaffControllers staffController = StaffControllers();
    return await staffController.updateStaffField(staffId, fieldName, newValue);
  } catch (error) {
    print('Database error: $error');
    return false;
  }
}
