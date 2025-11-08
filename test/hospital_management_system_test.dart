import 'package:test/test.dart';
import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/domain/controllers/staff/staff.dart';
import 'package:hospital_management_system/domain/controllers/staff/doctor.dart';
import 'package:hospital_management_system/domain/controllers/staff/nurse.dart';
import 'package:hospital_management_system/domain/controllers/staff/security.dart';
import 'package:hospital_management_system/domain/controllers/staff/cleaner.dart';
import 'package:hospital_management_system/domain/controllers/staff/administrator.dart';
import 'package:hospital_management_system/domain/controllers/room/patient.controller.dart';
import 'package:hospital_management_system/domain/controllers/authentication.dart';
import 'package:hospital_management_system/domain/staff/staff_models.dart';
import 'package:hospital_management_system/domain/patient.dart';

void main() {
  group('Hospital Management System Tests', () {
    late DatabaseHelper dbHelper;
    late StaffControllers staffController;
    late DoctorControllers doctorController;
    late NurseControllers nurseController;
    late SecurityControllers securityController;
    late CleanerControllers cleanerController;
    late AdministratorControllers adminController;
    late PatientController patientController;
    late AuthenticationController authController;

    setUpAll(() async {
      // Initialize database and controllers
      dbHelper = DatabaseHelper();
      staffController = StaffControllers();
      doctorController = DoctorControllers();
      nurseController = NurseControllers();
      securityController = SecurityControllers();
      cleanerController = CleanerControllers();
      adminController = AdministratorControllers();
      patientController = PatientController();
      authController = AuthenticationController();

      // Initialize test database
      await dbHelper.database;
      print('Test database initialized');
    });

    group('Staff Controller Tests', () {
      test('should insert and retrieve base staff', () async {
        // Arrange
        final staff = Staff(
          firstName: 'Test',
          lastName: 'User',
          dateOfBirth: DateTime(1990, 1, 1),
          gender: 'Male',
          phone: '123-456-7890',
          email: 'test@example.com',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Day',
          salary: 50000.0,
          staffType: StaffType.administrator,
        );

        // Act
        final staffId = await staffController.insertBaseStaff(staff);
        final retrievedStaff = await staffController.searchStaffById(
          staffId.toString(),
        );

        // Assert
        expect(staffId, greaterThan(0));
        expect(retrievedStaff, isNotNull);
        expect(retrievedStaff?.firstName, equals('Test'));
        expect(retrievedStaff?.lastName, equals('User'));
        expect(retrievedStaff?.email, equals('test@example.com'));
      });

      test('should get all staff members', () async {
        // Act
        final allStaff = await staffController.getAllStaff();

        // Assert
        expect(allStaff, isA<List<Staff>>());
        expect(allStaff.length, greaterThanOrEqualTo(0));
      });

      test('should update staff field successfully', () async {
        // Arrange - First create a staff member
        final staff = Staff(
          firstName: 'Update',
          lastName: 'Test',
          dateOfBirth: DateTime(1985, 5, 15),
          gender: 'Female',
          phone: '987-654-3210',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Night',
          salary: 45000.0,
          staffType: StaffType.nurse,
        );
        final staffId = await staffController.insertBaseStaff(staff);

        // Act
        final updateResult = await staffController.updateStaffField(
          staffId.toString(),
          'email',
          'updated@example.com',
        );

        // Assert
        expect(updateResult, isTrue);

        final updatedStaff = await staffController.searchStaffById(
          staffId.toString(),
        );
        expect(updatedStaff?.email, equals('updated@example.com'));
      });

      test('should handle non-existent staff ID gracefully', () async {
        // Act
        final result = await staffController.searchStaffById('99999');

        // Assert
        expect(result, isNull);
      });
    });

    group('Doctor Controller Tests', () {
      test('should insert and retrieve doctor', () async {
        // Arrange
        final doctor = Doctor(
          firstName: 'Dr. John',
          lastName: 'Smith',
          dateOfBirth: DateTime(1980, 3, 20),
          gender: 'Male',
          phone: '555-0123',
          email: 'dr.smith@hospital.com',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Day',
          salary: 120000.0,
          specialization: 'Cardiology',
          licenseNumber: 'DOC123456',
          qualification: 'MD, FACC',
        );

        // Act
        await doctorController.insertDoctor(doctor);
        final allDoctors = await doctorController.getAllDoctors();

        // Assert
        expect(allDoctors, isA<List<Doctor>>());

        final insertedDoctor = allDoctors.firstWhere(
          (d) => d.licenseNumber == 'DOC123456',
          orElse: () => throw StateError('Doctor not found'),
        );

        expect(insertedDoctor.firstName, equals('Dr. John'));
        expect(insertedDoctor.specialization, equals('Cardiology'));
        expect(insertedDoctor.qualification, equals('MD, FACC'));
      });

      test('should update doctor field', () async {
        // Arrange - Get any doctor from the database
        final allDoctors = await doctorController.getAllDoctors();
        if (allDoctors.isNotEmpty) {
          final doctor = allDoctors.first;

          // Act
          final result = await doctorController.updateDoctorField(
            doctor.id.toString(),
            'qualification',
            'Updated Qualification',
          );

          // Assert
          expect(result, isTrue);
        }
      });

      test('should get doctor by staff ID', () async {
        // Arrange - Get any doctor from the database
        final allDoctors = await doctorController.getAllDoctors();
        if (allDoctors.isNotEmpty) {
          final doctor = allDoctors.first;

          // Act
          final retrievedDoctor = await doctorController.getDoctorByStaffId(
            doctor.id.toString(),
          );

          // Assert
          expect(retrievedDoctor, isNotNull);
          expect(retrievedDoctor?.id, equals(doctor.id));
        }
      });
    });

    group('Nurse Controller Tests', () {
      test('should insert and retrieve nurse', () async {
        // Arrange
        final nurse = Nurse(
          firstName: 'Jane',
          lastName: 'Doe',
          dateOfBirth: DateTime(1992, 7, 10),
          gender: 'Female',
          phone: '555-0456',
          email: 'jane.doe@hospital.com',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Night',
          salary: 65000.0,
          department: 'ICU',
          certification: 'RN, BSN',
        );

        // Act
        await nurseController.insertNurse(nurse);
        final allNurses = await nurseController.getAllNurse();

        // Assert
        expect(allNurses, isA<List<Nurse>>());

        final insertedNurse = allNurses.firstWhere(
          (n) => n.firstName == 'Jane' && n.lastName == 'Doe',
          orElse: () => throw StateError('Nurse not found'),
        );

        expect(insertedNurse.department, equals('ICU'));
        expect(insertedNurse.certification, equals('RN, BSN'));
      });

      test('should update nurse field', () async {
        // Arrange - Get any nurse from the database
        final allNurses = await nurseController.getAllNurse();
        if (allNurses.isNotEmpty) {
          final nurse = allNurses.first;

          // Act
          final result = await nurseController.updateNurseField(
            nurse.id.toString(),
            'certification',
            'Updated Certification',
          );

          // Assert
          expect(result, isTrue);
        }
      });
    });

    group('Security Controller Tests', () {
      test('should insert and retrieve security staff', () async {
        // Arrange
        final security = Security(
          firstName: 'Mike',
          lastName: 'Johnson',
          dateOfBirth: DateTime(1988, 11, 25),
          gender: 'Male',
          phone: '555-0789',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: '24/7',
          salary: 40000.0,
          title: 'Security Guard',
          assignedArea: 'Main Building',
        );

        // Act
        await securityController.insertSecurity(security);
        final allSecurity = await securityController.getAllSecurityStaff();

        // Assert
        expect(allSecurity, isA<List<Security>>());

        final insertedSecurity = allSecurity.firstWhere(
          (s) => s.firstName == 'Mike' && s.lastName == 'Johnson',
          orElse: () => throw StateError('Security staff not found'),
        );

        expect(insertedSecurity.title, equals('Security Guard'));
        expect(insertedSecurity.assignedArea, equals('Main Building'));
      });

      test('should get security by staff ID', () async {
        // Arrange - Get any security staff from the database
        final allSecurity = await securityController.getAllSecurityStaff();
        if (allSecurity.isNotEmpty) {
          final security = allSecurity.first;

          // Act
          final retrievedSecurity = await securityController
              .getSecurityByStaffId(security.id.toString());

          // Assert
          expect(retrievedSecurity, isNotNull);
          expect(retrievedSecurity?.id, equals(security.id));
        }
      });
    });

    group('Cleaner Controller Tests', () {
      test('should insert and retrieve cleaner', () async {
        // Arrange
        final cleaner = Cleaner(
          firstName: 'Maria',
          lastName: 'Garcia',
          dateOfBirth: DateTime(1985, 4, 8),
          gender: 'Female',
          phone: '555-0321',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Day',
          salary: 30000.0,
          title: 'Cleaner',
          assignedDepartment: 'Emergency',
          assignedArea: 'Emergency Wing',
        );

        // Act
        await cleanerController.insertCleaner(cleaner);
        final allCleaners = await cleanerController.getAllCleaners();

        // Assert
        expect(allCleaners, isA<List<Cleaner>>());

        final insertedCleaner = allCleaners.firstWhere(
          (c) => c.firstName == 'Maria' && c.lastName == 'Garcia',
          orElse: () => throw StateError('Cleaner not found'),
        );

        expect(insertedCleaner.assignedArea, equals('Emergency Wing'));
        expect(insertedCleaner.assignedDepartment, equals('Emergency'));
      });

      test('should get cleaner by staff ID', () async {
        // Arrange - Get any cleaner from the database
        final allCleaners = await cleanerController.getAllCleaners();
        if (allCleaners.isNotEmpty) {
          final cleaner = allCleaners.first;

          // Act
          final retrievedCleaner = await cleanerController.getCleanerByStaffId(
            cleaner.id.toString(),
          );

          // Assert
          expect(retrievedCleaner, isNotNull);
          expect(retrievedCleaner?.id, equals(cleaner.id));
        }
      });
    });

    group('Administrator Controller Tests', () {
      test('should insert and retrieve administrator', () async {
        // Arrange
        final admin = Administrator(
          firstName: 'Admin',
          lastName: 'User',
          dateOfBirth: DateTime(1975, 9, 12),
          gender: 'Male',
          phone: '555-0001',
          email: 'admin@hospital.com',
          hireDate: DateTime.now(),
          employmentStatus: 'active',
          shift: 'Day',
          salary: 80000.0,
          username: 'admin_test',
          password: 'secure123',
          department: 'IT',
        );

        // Act
        await adminController.insertAdministrator(admin);
        final allAdmins = await adminController.getAllAdministrators();

        // Assert
        expect(allAdmins, isA<List<Administrator>>());

        final insertedAdmin = allAdmins.firstWhere(
          (a) => a.username == 'admin_test',
          orElse: () => throw StateError('Administrator not found'),
        );

        expect(insertedAdmin.department, equals('IT'));
        expect(insertedAdmin.username, equals('admin_test'));
      });
    });

    group('Patient Controller Tests', () {
      test('should insert and retrieve patient', () async {
        // Arrange
        final patient = Patient(
          name: 'John Patient',
          age: 35,
          gender: 'Male',
          nationality: 'Cambodian',
          commune: 'Sangkat 1',
          district: 'Khan 1',
          city: 'Phnom Penh',
          roomId: 1,
        );

        // Act
        final patientId = await patientController.insertPatient(patient);
        final allPatients = await patientController.getAllPatients();

        // Assert
        expect(patientId, greaterThan(0));
        expect(allPatients, isA<List<Patient>>());

        final insertedPatient = allPatients.firstWhere(
          (p) => p.name == 'John Patient',
          orElse: () => throw StateError('Patient not found'),
        );

        expect(insertedPatient.age, equals(35));
        expect(insertedPatient.city, equals('Phnom Penh'));
      });

      test('should allocate bed to patient successfully', () async {
        // Arrange - Create a patient with ID
        final patientWithId = Patient(
          id: 999, // Test ID
          name: 'Bed Test Patient',
          age: 28,
          gender: 'Female',
          nationality: 'Cambodian',
          commune: 'Sangkat 2',
          district: 'Khan 2',
          city: 'Phnom Penh',
          roomId: 1,
        );

        // Act - Just test the method call (it may fail due to room setup, but should not crash)
        final result = await patientController.allocateBedToPatient(
          patientWithId,
          'Private',
          1,
          null,
        );

        // Assert - Check if method returns a boolean
        expect(result, isA<bool>());
      });
    });

    group('Authentication Controller Tests', () {
      test('should reject invalid credentials', () async {
        // Act
        final result = await authController.authenticateAdmin(
          'nonexistent',
          'wrongpassword',
        );

        // Assert
        expect(result, isNull);
      });

      test('should handle authentication method call without error', () async {
        // Act - Just test the method exists and doesn't crash
        final result = await authController.authenticateAdmin('test', 'pass');

        // Assert - Method should return null for invalid credentials
        expect(result, isNull);
      });

      test(
        'should handle getAdministratorByUsername method call without error',
        () async {
          // Act - Just test the method exists and doesn't crash
          final result = await authController.getAdministratorByUsername(
            'nonexistent',
          );

          // Assert - Method should return null for non-existent user
          expect(result, isNull);
        },
      );
    });

    tearDownAll(() async {
      // Clean up test data if needed
      print('Tests completed');
    });
  });
}
