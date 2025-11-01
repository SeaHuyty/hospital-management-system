import 'dart:io';
import 'package:hospital_management_system/data/controllers/staff/doctor.dart';
import 'package:hospital_management_system/data/controllers/staff/nurse.dart';
import 'package:hospital_management_system/data/controllers/staff/security.dart';
import 'package:hospital_management_system/data/controllers/staff/cleaner.dart';
import 'package:hospital_management_system/data/controllers/staff/administrator.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';

Future<void> addNewStaffMenu() async {
  int? option;

  do {
    clearScreen();
    print("=== ADD NEW STAFF ===");
    print('1. Add Doctor');
    print('2. Add Nurse');
    print('3. Add Security Staff');
    print('4. Add Cleaner');
    print('5. Add Administrator');
    print('\n0. Back to Staff Menu');
    print('=' * 22);
    stdout.write('=> Select staff type to add: ');
    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');

    switch (option) {
      case 1:
        await addNewDoctor();
        pressEnterToContinue();
        break;

      case 2:
        await addNewNurse();
        pressEnterToContinue();
        break;

      case 3:
        await addNewSecurityStaff();
        pressEnterToContinue();
        break;

      case 4:
        await addNewCleaner();
        pressEnterToContinue();
        break;

      case 5:
        await addNewAdministrator();
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

// Helper function to collect common staff information
Map<String, dynamic>? collectBaseStaffInfo() {
  print('\n=== BASIC INFORMATION ===');

  // First Name
  stdout.write('First Name: ');
  String? firstName = stdin.readLineSync()?.trim();
  if (firstName == null || firstName.isEmpty) {
    print('First name is required!');
    return null;
  }

  // Last Name
  stdout.write('Last Name: ');
  String? lastName = stdin.readLineSync()?.trim();
  if (lastName == null || lastName.isEmpty) {
    print('Last name is required!');
    return null;
  }

  // Date of Birth
  stdout.write('Date of Birth (YYYY-MM-DD): ');
  String? dobInput = stdin.readLineSync()?.trim();
  DateTime? dateOfBirth;
  try {
    dateOfBirth = DateTime.parse(dobInput!);
    if (dateOfBirth.isAfter(DateTime.now())) {
      print('Date of birth cannot be in the future!');
      return null;
    }
  } catch (e) {
    print('Invalid date format! Please use YYYY-MM-DD format.');
    return null;
  }

  // Gender
  stdout.write('Gender (Male/Female): ');
  String? gender = stdin.readLineSync()?.trim();
  if (gender == null || gender.isEmpty) {
    print('Gender is required!');
    return null;
  }

  // Phone
  stdout.write('Phone (+855123456789): ');
  String? phone = stdin.readLineSync()?.trim();
  if (phone == null || phone.isEmpty) {
    print('Phone number is required!');
    return null;
  }

  // Email (Optional)
  stdout.write('Email (optional): ');
  String? email = stdin.readLineSync()?.trim();
  if (email != null && email.isEmpty) email = null;

  // Address (Optional)
  stdout.write('Address (optional): ');
  String? address = stdin.readLineSync()?.trim();
  if (address != null && address.isEmpty) address = null;

  // Emergency Contact Name (Optional)
  stdout.write('Emergency Contact Name (optional): ');
  String? emergencyContactName = stdin.readLineSync()?.trim();
  if (emergencyContactName != null && emergencyContactName.isEmpty) emergencyContactName = null;

  // Emergency Contact Phone (Optional)
  stdout.write('Emergency Contact Phone (optional): ');
  String? emergencyContactPhone = stdin.readLineSync()?.trim();
  if (emergencyContactPhone != null && emergencyContactPhone.isEmpty) emergencyContactPhone = null;

  // Employment Status (Default to active)
  String employmentStatus = 'active';

  // Shift
  stdout.write('Shift (Morning/Evening/Night): ');
  String? shift = stdin.readLineSync()?.trim();
  if (shift == null || shift.isEmpty) {
    print('Shift is required!');
    return null;
  }

  // Salary
  stdout.write('Monthly Salary (USD): ');
  String? salaryInput = stdin.readLineSync()?.trim();
  double? salary;
  try {
    salary = double.parse(salaryInput!);
    if (salary <= 0) {
      print('Salary must be positive!');
      return null;
    }
  } catch (e) {
    print('Invalid salary amount!');
    return null;
  }

  return {
    'firstName': firstName,
    'lastName': lastName,
    'dateOfBirth': dateOfBirth,
    'gender': gender,
    'phone': phone,
    'email': email,
    'address': address,
    'emergencyContactName': emergencyContactName,
    'emergencyContactPhone': emergencyContactPhone,
    'hireDate': DateTime.now(),
    'employmentStatus': employmentStatus,
    'shift': shift,
    'salary': salary,
  };
}

Future<void> addNewDoctor() async {
  clearScreen();
  print("=== ADD NEW DOCTOR ===");

  // Collect base information
  Map<String, dynamic>? baseInfo = collectBaseStaffInfo();
  if (baseInfo == null) return;

  // Collect doctor-specific information
  print('\n=== DOCTOR SPECIFIC INFORMATION ===');

  stdout.write('Medical Specialization: ');
  String? specialization = stdin.readLineSync()?.trim();
  if (specialization == null || specialization.isEmpty) {
    print('Specialization is required for doctors!');
    return;
  }

  stdout.write('Medical License Number: ');
  String? licenseNumber = stdin.readLineSync()?.trim();
  if (licenseNumber == null || licenseNumber.isEmpty) {
    print('License number is required for doctors!');
    return;
  }

  stdout.write('Qualifications: ');
  String? qualification = stdin.readLineSync()?.trim();
  if (qualification == null || qualification.isEmpty) {
    print('Qualifications are required for doctors!');
    return;
  }

  // Create and save doctor
  try {
    Doctor doctor = Doctor(
      firstName: baseInfo['firstName'],
      lastName: baseInfo['lastName'],
      dateOfBirth: baseInfo['dateOfBirth'],
      gender: baseInfo['gender'],
      phone: baseInfo['phone'],
      email: baseInfo['email'],
      address: baseInfo['address'],
      emergencyContactName: baseInfo['emergencyContactName'],
      emergencyContactPhone: baseInfo['emergencyContactPhone'],
      hireDate: baseInfo['hireDate'],
      employmentStatus: baseInfo['employmentStatus'],
      shift: baseInfo['shift'],
      salary: baseInfo['salary'],
      specialization: specialization,
      licenseNumber: licenseNumber,
      qualification: qualification,
    );

    DoctorControllers doctorController = DoctorControllers();
    await doctorController.insertDoctor(doctor);

    print('\nDoctor added successfully!');
    print('Name: ${baseInfo['firstName']} ${baseInfo['lastName']}');
    print('Specialization: $specialization');
  } catch (error) {
    print('Error adding doctor: $error');
  }
}

Future<void> addNewNurse() async {
  clearScreen();
  print("=== ADD NEW NURSE ===");

  // Collect base information
  Map<String, dynamic>? baseInfo = collectBaseStaffInfo();
  if (baseInfo == null) return;

  // Collect nurse-specific information
  print('\n=== NURSE SPECIFIC INFORMATION ===');

  stdout.write('Department: ');
  String? department = stdin.readLineSync()?.trim();
  if (department == null || department.isEmpty) {
    print('Department is required for nurses!');
    return;
  }

  stdout.write('Certifications: ');
  String? certification = stdin.readLineSync()?.trim();
  if (certification == null || certification.isEmpty) {
    print('Certifications are required for nurses!');
    return;
  }

  // Create and save nurse
  try {
    Nurse nurse = Nurse(
      firstName: baseInfo['firstName'],
      lastName: baseInfo['lastName'],
      dateOfBirth: baseInfo['dateOfBirth'],
      gender: baseInfo['gender'],
      phone: baseInfo['phone'],
      email: baseInfo['email'],
      address: baseInfo['address'],
      emergencyContactName: baseInfo['emergencyContactName'],
      emergencyContactPhone: baseInfo['emergencyContactPhone'],
      hireDate: baseInfo['hireDate'],
      employmentStatus: baseInfo['employmentStatus'],
      shift: baseInfo['shift'],
      salary: baseInfo['salary'],
      department: department,
      certification: certification,
    );

    NurseControllers nurseController = NurseControllers();
    await nurseController.insertNurse(nurse);

    print('\nNurse added successfully!');
    print('Name: ${baseInfo['firstName']} ${baseInfo['lastName']}');
    print('Department: $department');
  } catch (error) {
    print('Error adding nurse: $error');
  }
}

Future<void> addNewSecurityStaff() async {
  clearScreen();
  print("=== ADD NEW SECURITY STAFF ===");

  // Collect base information
  Map<String, dynamic>? baseInfo = collectBaseStaffInfo();
  if (baseInfo == null) return;

  // Collect security-specific information
  print('\n=== SECURITY SPECIFIC INFORMATION ===');

  stdout.write('Job Title: ');
  String? title = stdin.readLineSync()?.trim();
  if (title == null || title.isEmpty) {
    print('Job title is required for security staff!');
    return;
  }

  stdout.write('Assigned Area: ');
  String? assignedArea = stdin.readLineSync()?.trim();
  if (assignedArea == null || assignedArea.isEmpty) {
    print('Assigned area is required for security staff!');
    return;
  }

  // Create and save security staff
  try {
    Security security = Security(
      firstName: baseInfo['firstName'],
      lastName: baseInfo['lastName'],
      dateOfBirth: baseInfo['dateOfBirth'],
      gender: baseInfo['gender'],
      phone: baseInfo['phone'],
      email: baseInfo['email'],
      address: baseInfo['address'],
      emergencyContactName: baseInfo['emergencyContactName'],
      emergencyContactPhone: baseInfo['emergencyContactPhone'],
      hireDate: baseInfo['hireDate'],
      employmentStatus: baseInfo['employmentStatus'],
      shift: baseInfo['shift'],
      salary: baseInfo['salary'],
      title: title,
      assignedArea: assignedArea,
    );

    SecurityControllers securityController = SecurityControllers();
    await securityController.insertSecurity(security);

    print('\nSecurity staff added successfully!');
    print('Name: ${baseInfo['firstName']} ${baseInfo['lastName']}');
    print('Area: $assignedArea');
  } catch (error) {
    print('Error adding security staff: $error');
  }
}

Future<void> addNewCleaner() async {
  clearScreen();
  print("=== ADD NEW CLEANER ===");

  // Collect base information
  Map<String, dynamic>? baseInfo = collectBaseStaffInfo();
  if (baseInfo == null) return;

  // Collect cleaner-specific information
  print('\n=== CLEANER SPECIFIC INFORMATION ===');

  stdout.write('Job Title: ');
  String? title = stdin.readLineSync()?.trim();
  if (title == null || title.isEmpty) {
    print('Job title is required for cleaners!');
    return;
  }

  stdout.write('Assigned Department: ');
  String? assignedDepartment = stdin.readLineSync()?.trim();
  if (assignedDepartment == null || assignedDepartment.isEmpty) {
    print('Assigned department is required for cleaners!');
    return;
  }

  stdout.write('Assigned Area: ');
  String? assignedArea = stdin.readLineSync()?.trim();
  if (assignedArea == null || assignedArea.isEmpty) {
    print('Assigned area is required for cleaners!');
    return;
  }

  // Create and save cleaner
  try {
    Cleaner cleaner = Cleaner(
      firstName: baseInfo['firstName'],
      lastName: baseInfo['lastName'],
      dateOfBirth: baseInfo['dateOfBirth'],
      gender: baseInfo['gender'],
      phone: baseInfo['phone'],
      email: baseInfo['email'],
      address: baseInfo['address'],
      emergencyContactName: baseInfo['emergencyContactName'],
      emergencyContactPhone: baseInfo['emergencyContactPhone'],
      hireDate: baseInfo['hireDate'],
      employmentStatus: baseInfo['employmentStatus'],
      shift: baseInfo['shift'],
      salary: baseInfo['salary'],
      title: title,
      assignedDepartment: assignedDepartment,
      assignedArea: assignedArea,
    );

    CleanerControllers cleanerController = CleanerControllers();
    await cleanerController.insertCleaner(cleaner);

    print('\nCleaner added successfully!');
    print('Name: ${baseInfo['firstName']} ${baseInfo['lastName']}');
    print('Department: $assignedDepartment');
  } catch (error) {
    print('Error adding cleaner: $error');
  }
}

Future<void> addNewAdministrator() async {
  clearScreen();
  print("=== ADD NEW ADMINISTRATOR ===");

  // Collect base information
  Map<String, dynamic>? baseInfo = collectBaseStaffInfo();
  if (baseInfo == null) return;

  // Collect administrator-specific information
  print('\n=== ADMINISTRATOR SPECIFIC INFORMATION ===');

  stdout.write('Username: ');
  String? username = stdin.readLineSync()?.trim();
  if (username == null || username.isEmpty) {
    print('Username is required for administrators!');
    return;
  }

  stdout.write('Password: ');
  String? password = stdin.readLineSync()?.trim();
  if (password == null || password.isEmpty) {
    print('Password is required for administrators!');
    return;
  }

  stdout.write('Administrative Department: ');
  String? department = stdin.readLineSync()?.trim();
  if (department == null || department.isEmpty) {
    print('Department is required for administrators!');
    return;
  }

  // Create and save administrator
  try {
    Administrator administrator = Administrator(
      firstName: baseInfo['firstName'],
      lastName: baseInfo['lastName'],
      dateOfBirth: baseInfo['dateOfBirth'],
      gender: baseInfo['gender'],
      phone: baseInfo['phone'],
      email: baseInfo['email'],
      address: baseInfo['address'],
      emergencyContactName: baseInfo['emergencyContactName'],
      emergencyContactPhone: baseInfo['emergencyContactPhone'],
      hireDate: baseInfo['hireDate'],
      employmentStatus: baseInfo['employmentStatus'],
      shift: baseInfo['shift'],
      salary: baseInfo['salary'],
      username: username,
      password: password,
      department: department,
    );

    AdministratorControllers adminController = AdministratorControllers();
    await adminController.insertAdministrator(administrator);

    print('\nAdministrator added successfully!');
    print('Name: ${baseInfo['firstName']} ${baseInfo['lastName']}');
    print('Username: $username');
  } catch (error) {
    print('Error adding administrator: $error');
  }
}
