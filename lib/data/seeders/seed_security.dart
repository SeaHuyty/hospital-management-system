import '../controllers/staff/security.dart';
import '../../domain/staff/staff_models.dart';

Future<void> seedSecurityStaff() async {
  SecurityControllers securityController = SecurityControllers();

  // Security 1 - Main Entrance
  Security security1 = Security(
    firstName: 'John',
    lastName: 'Martinez',
    dateOfBirth: DateTime(1988, 9, 14),
    gender: 'Male',
    phone: '+855666777888',
    email: 'john.martinez@hospital.com',
    address: '159 Security Drive, Phnom Penh',
    emergencyContactName: 'Maria Martinez',
    emergencyContactPhone: '+855666777889',
    hireDate: DateTime(2020, 4, 1),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 1800.0,
    title: 'Security Officer',
    assignedArea: 'Main Entrance',
  );
  await securityController.insertSecurity(security1);

  // Security 2 - Emergency Department
  Security security2 = Security(
    firstName: 'Robert',
    lastName: 'Garcia',
    dateOfBirth: DateTime(1983, 12, 3),
    gender: 'Male',
    phone: '+855999000111',
    email: 'robert.garcia@hospital.com',
    address: '753 Guardian Street, Phnom Penh',
    emergencyContactName: 'Elena Garcia',
    emergencyContactPhone: '+855999000112',
    hireDate: DateTime(2019, 8, 15),
    employmentStatus: 'active',
    shift: 'Evening',
    salary: 1900.0,
    title: 'Senior Security Officer',
    assignedArea: 'Emergency Department',
  );
  await securityController.insertSecurity(security2);

  // Security 3 - Parking Area
  Security security3 = Security(
    firstName: 'Kevin',
    lastName: 'Thompson',
    dateOfBirth: DateTime(1992, 4, 18),
    gender: 'Male',
    phone: '+855222333444',
    email: 'kevin.thompson@hospital.com',
    address: '951 Watch Tower Ave, Phnom Penh',
    emergencyContactName: 'Jennifer Thompson',
    emergencyContactPhone: '+855222333445',
    hireDate: DateTime(2022, 1, 10),
    employmentStatus: 'active',
    shift: 'Night',
    salary: 1750.0,
    title: 'Security Guard',
    assignedArea: 'Parking Area',
  );
  await securityController.insertSecurity(security3);

  print('Security staff seeded successfully!');
}
