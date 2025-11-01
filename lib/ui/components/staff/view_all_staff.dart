import 'package:hospital_management_system/data/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/staff.dart';
import 'package:hospital_management_system/ui/components/clear_screen.dart';
import 'package:hospital_management_system/ui/components/table_printer.dart';

Future<void> viewAllStaffs() async {
  try {
    // Clear screen for better presentation
    clearScreen();
    print("=== VIEW ALL STAFF ===");

    // Small delay to ensure any previous operations are complete
    await Future.delayed(Duration(milliseconds: 200));

    StaffControllers staffController = StaffControllers();
    List<Staff> staff = await staffController.getAllStaff();

    if (staff.isEmpty) {
      print('No staff found in the database.');
    } else {
      print('Found ${staff.length} staff member(s):\n');

      // Prepare table data
      List<String> headers = [
        'ID',
        'Name',
        'DOB',
        'Gender',
        'Phone',
        'Email',
        'Status',
        'Shift',
        'Salary',
        'Staff Type',
      ];

      List<List<String>> rows = staff.map((member) {
        return [
          member.id?.toString() ?? 'N/A',
          '${member.firstName} ${member.lastName}',
          member.dateOfBirth.toString().split(' ')[0], // Just the date part
          member.gender,
          member.phone,
          member.email ?? 'N/A',
          member.employmentStatus,
          member.shift,
          '\$${member.salary}',
          member.staffType.toString().split('.').last, // Remove enum prefix
        ];
      }).toList();

      // Print the table
      printTable(headers: headers, rows: rows, tabs: 1);
    }
  } catch (error) {
    print('Error retrieving staff: $error');
  }
}
