import 'package:hospital_management_system/data/seeders/seed_beds.dart';
import 'package:hospital_management_system/data/seeders/seed_departments.dart';
import 'package:hospital_management_system/data/seeders/seed_room_type.dart';
import 'package:hospital_management_system/data/seeders/seed_rooms.dart';

import 'seed_doctors.dart';
import 'seed_nurses.dart';
import 'seed_security.dart';
import 'seed_cleaners.dart';
import 'seed_administrators.dart';

Future<void> seedAllStaff() async {
  try {
    print('\n');

    await seedDoctors();
    await seedNurses();
    await seedSecurityStaff();
    await seedCleaners();
    await seedAdministrators();
    await seedDepartments();
    await seedRoomTypes();
    await seedRooms();
    await seedBeds();

    print('\nAll staff seeded successfully!');
    print('Summary:');
    print('- 6 Doctors');
    print('- 4 Nurses');
    print('- 3 Security Staff');
    print('- 4 Cleaners');
    print('- 2 Administrators');
    print('Total: 19 staff members');
  } catch (error) {
    print('Error seeding staff: $error');
    rethrow;
  }
}
