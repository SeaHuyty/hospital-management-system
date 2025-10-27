import 'package:hospital_management_system/data/controllers/doctor.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/pause_message.dart';

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