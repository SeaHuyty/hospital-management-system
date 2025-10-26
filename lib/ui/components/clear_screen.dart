import 'dart:io';

Future<void> clearScreen() async {
  await Future.delayed(Duration(milliseconds: 10));
  stdout.write('\x1B[2J\x1B[0;0H');
}