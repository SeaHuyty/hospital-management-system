import 'dart:io';

void pauseMessage([String message = 'Press Enter to continue...']) {
  stdout.write('\n$message');
  stdin.readLineSync();
}