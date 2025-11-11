import '../controllers/staff/cleaner.dart';
import '../../domain/staff/staff_models.dart';

Future<void> seedCleaners() async {
  CleanerControllers cleanerController = CleanerControllers();

  // Cleaner 1 - Operating Room
  Cleaner cleaner1 = Cleaner(
    firstName: 'Maria',
    lastName: 'Rodriguez',
    dateOfBirth: DateTime(1986, 6, 25),
    gender: 'Female',
    phone: '+855555666777',
    email: 'maria.rodriguez@hospital.com',
    address: '357 Clean Street, Phnom Penh',
    emergencyContactName: 'Carlos Rodriguez',
    emergencyContactPhone: '+855555666778',
    hireDate: DateTime(2020, 3, 20),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 1500.0,
    title: 'Senior Cleaner',
    assignedDepartment: 'Surgery Department',
    assignedArea: 'Operating Rooms',
  );
  await cleanerController.insertCleaner(cleaner1);

  // Cleaner 2 - Patient Rooms
  Cleaner cleaner2 = Cleaner(
    firstName: 'Lisa',
    lastName: 'Anderson',
    dateOfBirth: DateTime(1991, 10, 12),
    gender: 'Female',
    phone: '+855888999000',
    email: 'lisa.anderson@hospital.com',
    address: '642 Hygiene Ave, Phnom Penh',
    emergencyContactName: 'Mark Anderson',
    emergencyContactPhone: '+855888999001',
    hireDate: DateTime(2021, 7, 5),
    employmentStatus: 'active',
    shift: 'Evening',
    salary: 1400.0,
    title: 'Room Cleaner',
    assignedDepartment: 'General Medicine',
    assignedArea: 'Patient Rooms (Floor 2-3)',
  );
  await cleanerController.insertCleaner(cleaner2);

  // Cleaner 3 - Common Areas
  Cleaner cleaner3 = Cleaner(
    firstName: 'David',
    lastName: 'Lee',
    dateOfBirth: DateTime(1989, 2, 8),
    gender: 'Male',
    phone: '+855111333555',
    email: 'david.lee@hospital.com',
    address: '258 Maintenance Road, Phnom Penh',
    emergencyContactName: 'Anna Lee',
    emergencyContactPhone: '+855111333556',
    hireDate: DateTime(2019, 11, 15),
    employmentStatus: 'active',
    shift: 'Night',
    salary: 1450.0,
    title: 'Facilities Cleaner',
    assignedDepartment: 'Facilities Management',
    assignedArea: 'Lobby, Corridors, Cafeteria',
  );
  await cleanerController.insertCleaner(cleaner3);

  // Cleaner 4 - ICU Department
  Cleaner cleaner4 = Cleaner(
    firstName: 'Sofia',
    lastName: 'Patel',
    dateOfBirth: DateTime(1994, 8, 30),
    gender: 'Female',
    phone: '+855777222999',
    email: 'sofia.patel@hospital.com',
    address: '147 Sanitation Lane, Phnom Penh',
    emergencyContactName: 'Raj Patel',
    emergencyContactPhone: '+855777222998',
    hireDate: DateTime(2022, 5, 12),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 1550.0,
    title: 'ICU Cleaner',
    assignedDepartment: 'Intensive Care Unit',
    assignedArea: 'ICU Rooms and Equipment',
  );
  await cleanerController.insertCleaner(cleaner4);

  print('Cleaners seeded successfully!');
}
