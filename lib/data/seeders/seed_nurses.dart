import '../controllers/staff/nurse.dart';
import '../../domain/staff/staff_models.dart';

Future<void> seedNurses() async {
  NurseControllers nurseController = NurseControllers();

  // Nurse 1 - Emergency Department
  Nurse nurse1 = Nurse(
    firstName: 'Emily',
    lastName: 'Johnson',
    dateOfBirth: DateTime(1985, 3, 12),
    gender: 'Female',
    phone: '+855111222333',
    email: 'emily.johnson@hospital.com',
    address: '123 Nursing Ave, Phnom Penh',
    emergencyContactName: 'David Johnson',
    emergencyContactPhone: '+855111222334',
    hireDate: DateTime(2019, 6, 15),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 2500.0,
    department: 'Emergency Department',
    certification: 'RN, BLS, ACLS',
  );
  await nurseController.insertNurse(nurse1);

  // Nurse 2 - Intensive Care Unit
  Nurse nurse2 = Nurse(
    firstName: 'Michael',
    lastName: 'Brown',
    dateOfBirth: DateTime(1982, 11, 28),
    gender: 'Male',
    phone: '+855444555666',
    email: 'michael.brown@hospital.com',
    address: '456 Care Street, Phnom Penh',
    emergencyContactName: 'Lisa Brown',
    emergencyContactPhone: '+855444555667',
    hireDate: DateTime(2017, 9, 1),
    employmentStatus: 'active',
    shift: 'Night',
    salary: 2800.0,
    department: 'Intensive Care Unit',
    certification: 'RN, CCRN, BLS',
  );
  await nurseController.insertNurse(nurse2);

  // Nurse 3 - Pediatrics
  Nurse nurse3 = Nurse(
    firstName: 'Amanda',
    lastName: 'Davis',
    dateOfBirth: DateTime(1990, 7, 5),
    gender: 'Female',
    phone: '+855777888999',
    email: 'amanda.davis@hospital.com',
    address: '789 Pediatric Lane, Phnom Penh',
    emergencyContactName: 'Robert Davis',
    emergencyContactPhone: '+855777888998',
    hireDate: DateTime(2021, 2, 10),
    employmentStatus: 'active',
    shift: 'Evening',
    salary: 2400.0,
    department: 'Pediatrics',
    certification: 'RN, CPN, PALS',
  );
  await nurseController.insertNurse(nurse3);

  // Nurse 4 - Surgery Department
  Nurse nurse4 = Nurse(
    firstName: 'James',
    lastName: 'Wilson',
    dateOfBirth: DateTime(1987, 1, 20),
    gender: 'Male',
    phone: '+855333444555',
    email: 'james.wilson@hospital.com',
    address: '321 Surgery Blvd, Phnom Penh',
    emergencyContactName: 'Sarah Wilson',
    emergencyContactPhone: '+855333444556',
    hireDate: DateTime(2018, 12, 5),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 2700.0,
    department: 'Surgery Department',
    certification: 'RN, CNOR, BLS',
  );
  await nurseController.insertNurse(nurse4);

  print('Nurses seeded successfully!');
}
