import 'dart:io';
import 'package:hospital_management_system/data/controllers/staff/doctor.dart';
import 'package:hospital_management_system/data/controllers/staff/nurse.dart';
import 'package:hospital_management_system/data/controllers/staff/security.dart';
import 'package:hospital_management_system/data/controllers/staff/cleaner.dart';
import 'package:hospital_management_system/data/controllers/staff/administrator.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';

Future<void> staffViewByRole() async {
  int? option;

  do {
    clearScreen();
    print("=== VIEW STAFF BY ROLE ===");
    print('1. View All Doctors');
    print('2. View All Nurses');
    print('3. View All Security Staff');
    print('4. View All Cleaners');
    print('5. View All Administrators');
    print('\n0. Back to Staff Menu');
    print('=' * 27);
    stdout.write('=> Select an option: ');
    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');

    switch (option) {
      case 1:
        await viewAllDoctors();
        pressEnterToContinue();
        break;

      case 2:
        await viewAllNurses();
        pressEnterToContinue();
        break;

      case 3:
        await viewAllSecurityStaff();
        pressEnterToContinue();
        break;

      case 4:
        await viewAllCleaners();
        pressEnterToContinue();
        break;

      case 5:
        await viewAllAdministrators();
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

Future<void> viewAllDoctors() async {
  try {
    clearScreen();
    print("=== ALL DOCTORS ===");

    DoctorControllers doctorController = DoctorControllers();
    List<Doctor> doctors = await doctorController.getAllDoctors();

    if (doctors.isEmpty) {
      print('No doctors found in the database.');
    } else {
      print('Found ${doctors.length} doctor(s):\n');

      // Prepare table data for doctors
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Specialization',
        'License',
        'Qualification',
        'Shift',
        'Salary',
      ];

      List<List<String>> rows = doctors.map((doctor) {
        return [
          doctor.id?.toString() ?? 'N/A',
          '${doctor.firstName} ${doctor.lastName}',
          doctor.dateOfBirth.toString().split(' ')[0],
          doctor.gender,
          doctor.phone,
          doctor.specialization,
          doctor.licenseNumber,
          doctor.qualification,
          doctor.shift,
          '\$${doctor.salary}',
        ];
      }).toList();

      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving doctors: $error');
  }
}

Future<void> viewAllNurses() async {
  try {
    clearScreen();
    print("=== ALL NURSES ===");

    NurseControllers nurseController = NurseControllers();
    List<Nurse> nurses = await nurseController.getAllNurse();

    if (nurses.isEmpty) {
      print('No nurses found in the database.');
    } else {
      print('Found ${nurses.length} nurse(s):\n');

      // Prepare table data for nurses
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Department',
        'Certification',
        'Shift',
        'Salary',
      ];

      List<List<String>> rows = nurses.map((nurse) {
        return [
          nurse.id?.toString() ?? 'N/A',
          '${nurse.firstName} ${nurse.lastName}',
          nurse.dateOfBirth.toString().split(' ')[0],
          nurse.gender,
          nurse.phone,
          nurse.department,
          nurse.certification,
          nurse.shift,
          '\$${nurse.salary}',
        ];
      }).toList();

      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving nurses: $error');
  }
}

Future<void> viewAllSecurityStaff() async {
  try {
    clearScreen();
    print("=== ALL SECURITY STAFF ===");

    SecurityControllers securityController = SecurityControllers();
    List<Security> securityStaff = await securityController
        .getAllSecurityStaff();

    if (securityStaff.isEmpty) {
      print('No security staff found in the database.');
    } else {
      print('Found ${securityStaff.length} security staff member(s):\n');

      // Prepare table data for security staff
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Title',
        'Assigned Area',
        'Shift',
        'Salary',
      ];

      List<List<String>> rows = securityStaff.map((security) {
        return [
          security.id?.toString() ?? 'N/A',
          '${security.firstName} ${security.lastName}',
          security.dateOfBirth.toString().split(' ')[0],
          security.gender,
          security.phone,
          security.title,
          security.assignedArea,
          security.shift,
          '\$${security.salary}',
        ];
      }).toList();

      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving security staff: $error');
  }
}

Future<void> viewAllCleaners() async {
  try {
    clearScreen();
    print("=== ALL CLEANERS ===");

    CleanerControllers cleanerController = CleanerControllers();
    List<Cleaner> cleaners = await cleanerController.getAllCleaners();

    if (cleaners.isEmpty) {
      print('No cleaners found in the database.');
    } else {
      print('Found ${cleaners.length} cleaner(s):\n');

      // Prepare table data for cleaners
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Title',
        'Department',
        'Area',
        'Shift',
        'Salary',
      ];

      List<List<String>> rows = cleaners.map((cleaner) {
        return [
          cleaner.id?.toString() ?? 'N/A',
          '${cleaner.firstName} ${cleaner.lastName}',
          cleaner.dateOfBirth.toString().split(' ')[0],
          cleaner.gender,
          cleaner.phone,
          cleaner.title,
          cleaner.assignedDepartment,
          cleaner.assignedArea,
          cleaner.shift,
          '\$${cleaner.salary}',
        ];
      }).toList();

      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving cleaners: $error');
  }
}

Future<void> viewAllAdministrators() async {
  try {
    clearScreen();
    print("=== ALL ADMINISTRATORS ===");

    AdministratorControllers adminController = AdministratorControllers();
    List<Administrator> administrators = await adminController
        .getAllAdministrators();

    if (administrators.isEmpty) {
      print('No administrators found in the database.');
    } else {
      print('Found ${administrators.length} administrator(s):\n');

      // Prepare table data for administrators
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Username',
        'Department',
        'Shift',
        'Salary',
      ];

      List<List<String>> rows = administrators.map((admin) {
        return [
          admin.id?.toString() ?? 'N/A',
          '${admin.firstName} ${admin.lastName}',
          admin.dateOfBirth.toString().split(' ')[0],
          admin.gender,
          admin.phone,
          admin.username,
          admin.department,
          admin.shift,
          '\$${admin.salary}',
        ];
      }).toList();

      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving administrators: $error');
  }
}
