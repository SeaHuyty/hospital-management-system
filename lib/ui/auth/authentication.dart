import 'dart:io';
import '../../domain/staff.dart';
import '../../data/controllers/authentication.dart';

Future<Administrator?> authentication() async {
  stdout.write('\n\nEnter your username: ');
  String? username = stdin.readLineSync();
  stdout.write('Enter your password: ');
  String? password = stdin.readLineSync();

  if (username == null || username.isEmpty || password == null || password.isEmpty) {
    print('Username or Password can not be empty.\n System Terminated');
    return null;
  }

  AuthenticationController authController = AuthenticationController();

  Administrator? admin = await authController.authenticateAdmin(username, password);

  return admin;
}