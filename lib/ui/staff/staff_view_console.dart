import 'dart:io';
import './../components/pause_message.dart';

Future<void> staffConsole() async {
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
        pressEnterToContinue();
        break;
      case 2:
        print('View All Based on Role');
        pressEnterToContinue();
        break;
      case 3:
        print('Search Staff By ID');
        pressEnterToContinue();
        break;
      default:
        print('Please enter a valid option');
        pressEnterToContinue();
        break;
    }
  } while (option != 0);
}