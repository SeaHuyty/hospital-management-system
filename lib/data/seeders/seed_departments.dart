import 'package:hospital_management_system/data/controllers/room/department_controller.dart';
import 'package:hospital_management_system/domain/hospital_room.dart';

Future<void> seedDepartments() async {
  DepartmentController departmentController = DepartmentController();

  final departments = [
    Department(name: 'Cardiology'),
    Department(name: 'Neurology'),
    Department(name: 'Orthopedics'),
    Department(name: 'Pediatrics'),
    Department(name: 'General Medicine'),
  ];

  for (var dep in departments) {
    await departmentController.insertDepartment(dep);
  }

  print('Departments seeded successfully!');
}
