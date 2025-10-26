import 'dart:io';

Future<void> pressEnterToContinue() async {
  stdout.write('\nPress Enter to continue...');
  stdin.readLineSync(); // safe when everything else uses readLineSync
}
