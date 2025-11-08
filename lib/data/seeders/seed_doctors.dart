import '../../domain/controllers/staff/doctor.dart';
import '../../domain/staff/staff_models.dart';

Future<void> seedDoctors() async {
  DoctorControllers doctorController = DoctorControllers();

  // Doctor 1 - Cardiologist
  Doctor doctor1 = Doctor(
    firstName: 'Sok',
    lastName: 'Bunkoing',
    dateOfBirth: DateTime(1980, 5, 15),
    gender: 'Male',
    phone: '+855123456789',
    email: 'sok.bunkoing@hospital.com',
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

  // Doctor 3 - Orthopedic Surgeon
  Doctor doctor3 = Doctor(
    firstName: 'Michael',
    lastName: 'Chen',
    dateOfBirth: DateTime(1978, 12, 10),
    gender: 'Male',
    phone: '+855555123456',
    email: 'michael.chen@hospital.com',
    address: '789 Medical Plaza, Phnom Penh',
    emergencyContactName: 'Linda Chen',
    emergencyContactPhone: '+855555123457',
    hireDate: DateTime(2016, 7, 22),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 6000.0,
    specialization: 'Orthopedic Surgery',
    licenseNumber: 'MD345678',
    qualification: 'MBBS, MS Orthopedics, Fellowship in Joint Replacement',
  );
  await doctorController.insertDoctor(doctor3);

  // Doctor 4 - Pediatrician
  Doctor doctor4 = Doctor(
    firstName: 'Jennifer',
    lastName: 'Smith',
    dateOfBirth: DateTime(1983, 4, 18),
    gender: 'Female',
    phone: '+855777888999',
    email: 'jennifer.smith@hospital.com',
    address: '456 Pediatric Center, Phnom Penh',
    emergencyContactName: 'Robert Smith',
    emergencyContactPhone: '+855777888998',
    hireDate: DateTime(2019, 2, 14),
    employmentStatus: 'active',
    shift: 'Evening',
    salary: 4800.0,
    specialization: 'Pediatrics',
    licenseNumber: 'MD567890',
    qualification: 'MBBS, MD Pediatrics, DCH',
  );
  await doctorController.insertDoctor(doctor4);

  // Doctor 5 - General Surgeon
  Doctor doctor5 = Doctor(
    firstName: 'Alexander',
    lastName: 'Kumar',
    dateOfBirth: DateTime(1979, 9, 5),
    gender: 'Male',
    phone: '+855333222111',
    email: 'alexander.kumar@hospital.com',
    address: '321 Surgery Wing, Phnom Penh',
    emergencyContactName: 'Priya Kumar',
    emergencyContactPhone: '+855333222112',
    hireDate: DateTime(2015, 11, 8),
    employmentStatus: 'active',
    shift: 'Morning',
    salary: 5200.0,
    specialization: 'General Surgery',
    licenseNumber: 'MD901234',
    qualification: 'MBBS, MS General Surgery',
  );
  await doctorController.insertDoctor(doctor5);

  // Doctor 6 - Radiologist
  Doctor doctor6 = Doctor(
    firstName: 'Rachel',
    lastName: 'White',
    dateOfBirth: DateTime(1981, 1, 28),
    gender: 'Female',
    phone: '+855999888777',
    email: 'rachel.white@hospital.com',
    address: '654 Radiology Department, Phnom Penh',
    emergencyContactName: 'James White',
    emergencyContactPhone: '+855999888778',
    hireDate: DateTime(2017, 5, 17),
    employmentStatus: 'active',
    shift: 'Night',
    salary: 4900.0,
    specialization: 'Radiology',
    licenseNumber: 'MD234567',
    qualification: 'MBBS, MD Radiology, DMRD',
  );
  await doctorController.insertDoctor(doctor6);

  print('Doctors seeded successfully!');
}
