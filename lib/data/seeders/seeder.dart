import '../controllers/doctor.dart';
import '../../domain/staff.dart';

Future<void> seedAllStaff() async {
  try {
    await seedDoctors();
    
    print('All staff seeded successfully!');
  } catch (error) {
    print('Error seeding staff: $error');
  }
}

Future<void> seedDoctors() async {
  DoctorControllers doctorController = DoctorControllers();

  // Doctor 1 - Cardiologist
  Doctor doctor1 = Doctor(
    firstName: 'John',
    lastName: 'Smith',
    dateOfBirth: DateTime(1980, 5, 15),
    gender: 'Male',
    phone: '+855123456789',
    email: 'john.smith@hospital.com',
    hireDate: DateTime(2020, 1, 15),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 5000.0,
    specialization: 'Cardiology',
    licenseNumber: 'MD123456',
    qualification: 'MBBS, MD Cardiology',
  );
  await doctorController.insertDoctor(doctor1);

  // Doctor 2 - Neurologist
  Doctor doctor2 = Doctor(
    firstName: 'Sarah',
    lastName: 'Wilson',
    dateOfBirth: DateTime(1975, 8, 22),
    gender: 'Female',
    phone: '+855987654321',
    email: 'sarah.wilson@hospital.com',
    hireDate: DateTime(2018, 3, 10),
    employmentStatus: 'active',
    shift: 'Evening',
    salary: 5500.0,
    specialization: 'Neurology',
    licenseNumber: 'MD789012',
    qualification: 'MBBS, MD Neurology',
  );
  await doctorController.insertDoctor(doctor2);

  print('Doctors seeded successfully!');
}