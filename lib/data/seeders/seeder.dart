import 'seed_doctors.dart';
import 'seed_nurses.dart';
import 'seed_security.dart';
import 'seed_cleaners.dart';
import 'seed_administrators.dart';

Future<void> seedAllStaff() async {
  try {
    print('Starting to seed all staff...\n');

    await seedDoctors();
    await seedNurses();
    await seedSecurityStaff();
    await seedCleaners();
    await seedAdministrators();

    print('\n🎉 All staff seeded successfully!');
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
