import 'dart:io';
import './../components/pause_message.dart';

void staffConsole() {
  int? option;
  do {
    print("--- View Staff ---");
    print('1. View All Staff');
    print('2. View All Based on Role');
    print('3. Search Staff By ID');
    print('0. Back');
    stdout.write('=> Select an option: ');
    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');
    switch (option) {
      case 1:
        print('View All Staff');
        pauseMessage();
        break;
      case 2:
        print('View All Based on Role');
        pauseMessage();
        break;
      case 3:
        print('Search Staff By ID');
        pauseMessage();
        break;
      default:
        print('Please enter a valid option');
        pauseMessage();
        break;
    }
  } while (option != 0);
}