import 'package:hospital_management_system/ui/components/loading_bar.dart';
import 'package:hospital_management_system/ui/hospital_console.dart';
import 'package:hospital_management_system/data/config/database.dart';
import 'package:hospital_management_system/data/seeders/seeder.dart';

Future<void> main() async {
  try {
    // Uncomment this line to recreate tables during development
    await _recreateTablesForDevelopment();
    await seedAllStaff();

    HospitalConsole console = HospitalConsole();
    DatabaseHelper database = DatabaseHelper();

    print('Connecting to database...');
    bool connected = await database.connectToDatabase();

    if (!connected) {
      print('Failed to connect to database.');
      return;
    }

    print('Database connected successfully!');
    await loadingBar();

    print('Starting console...');
    await console.start();
  } catch (error) {
    print('Error in main: $error');
  }
}

Future<void> _recreateTablesForDevelopment() async {
  print('Recreating tables...');
  DatabaseHelper database = DatabaseHelper();
  await database.recreateTables();
  print('Tables recreated');
}