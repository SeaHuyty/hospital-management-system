import 'package:hospital_management_system/data/config/database.dart';

void main(List<String> arguments) async {
  DatabaseHelper dbHelper = DatabaseHelper();

  bool isConnected = await dbHelper.connectToDatabase();

  if (isConnected) {
    print('Database connected successfully');
  } else {
    print('Failed to connect to database.');
  }
}
