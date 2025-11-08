import 'dart:io';
import 'package:hospital_management_system/ui/components/pause_message.dart';

import '../../domain/staff/staff_models.dart';
import '../../domain/controllers/authentication.dart';

class Session {
  static Administrator? currentAdmin;
}

Future<Administrator?> authentication() async {
  if (Session.currentAdmin != null) {
    return Session.currentAdmin;
  }

  stdout.write('\n\nEnter your username: ');
  String? username = stdin.readLineSync();
  stdout.write('Enter your password: ');
  String? password = stdin.readLineSync();

  if (username == null ||
      username.isEmpty ||
      password == null ||
      password.isEmpty) {
    print('Username or Password can not be empty.\n System Terminated');
    return null;
  }

  AuthenticationController authController = AuthenticationController();

  Administrator? admin = await authController.authenticateAdmin(
    username,
    password,
  );

  if (admin != null) {
    Session.currentAdmin = admin;
    print('\nLogin successful. Welcome, ${admin.username}!');
    pressEnterToContinue();
  } else {
    print('\nAuthentication failed.');
  }

  return admin;
}
