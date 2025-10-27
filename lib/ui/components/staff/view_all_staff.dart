import 'package:hospital_management_system/data/controllers/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';

Future<void> viewAllStaffs() async {
  try {
    // Clear screen for better presentation
    clearScreen();
    print("=== VIEW ALL STAFF ===");

    // Small delay to ensure any previous operations are complete
    await Future.delayed(Duration(milliseconds: 200));

    StaffControllers staffController = StaffControllers();
    print('\nRetrieving all staff...');
    List<Staff> staff = await staffController.getAllStaff();

    if (staff.isEmpty) {
      print('No staff found in the database.');
    } else {
      print('Found ${staff.length} staff member(s):');
      for (int i = 0; i < staff.length; i++) {
        Staff member = staff[i];
        print('\n--- Staff Member ${i + 1} ---');
        print('ID: ${member.id}');
        print('Name: ${member.firstName} ${member.lastName}');
        print('Date of Birth: ${member.dateOfBirth}');
        print('Gender: ${member.gender}');
        print('Phone: ${member.phone}');
        print('Salary: \$${member.salary}');
        print('Status: ${member.employmentStatus}');
        print('Shift: ${member.shift}');
        print('Staff Type: ${member.staffType}');
        print('Created At: ${member.createdAt}');
        print('Updated At: ${member.updatedAt}');
      }
    }
  } catch (error) {
    print('Error retrieving staff: $error');
  }
}