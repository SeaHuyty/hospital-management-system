import '../controllers/staff/administrator.dart';
import '../../domain/staff.dart';

Future<void> seedAdministrators() async {
  AdministratorControllers administratorController = AdministratorControllers();

  // Administrator 1 - Sea Huyty
  Administrator admin1 = Administrator(
    firstName: 'Sea',
    lastName: 'Huyty',
    dateOfBirth: DateTime(1985, 6, 15),
    gender: 'Male',
    phone: '+855100200300',
    email: 'sea.huyty@hospital.admin.com',
    address: '101 Admin Tower, Phnom Penh',
    emergencyContactName: 'Huyty Family',
    emergencyContactPhone: '+855100200301',
    hireDate: DateTime(2020, 1, 1),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 6500.0,
    username: 'sea.huyty',
    password: 'admin123', // In production, this should be hashed
    department: 'Hospital Management',
  );
  await administratorController.insertAdministrator(admin1);

  // Administrator 2 - Chetha Navid
  Administrator admin2 = Administrator(
    firstName: 'Chetha',
    lastName: 'Navid',
    dateOfBirth: DateTime(1982, 9, 22),
    gender: 'Male',
    phone: '+855400500600',
    email: 'chetha.navid@hospital.admin.com',
    address: '202 Executive Wing, Phnom Penh',
    emergencyContactName: 'Navid Family',
    emergencyContactPhone: '+855400500601',
    hireDate: DateTime(2019, 3, 15),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 7000.0,
    username: 'chetha.navid',
    password: 'secure456', // In production, this should be hashed
    department: 'IT Administration',
  );
  await administratorController.insertAdministrator(admin2);

  print('Administrators seeded successfully!');
}
