import 'dart:io';

void staffConsole() {
  int? option;
  do {
    print("--- Staff Management ---");
    print('1. View Staff');
    print('2. Add new staff');
    print('3. Edit staff');
    print('0. Back');
    stdout.write('=> Select an option: ');
    String? input = stdin.readLineSync();
    option = int.tryParse(input ?? '');
    switch (option) {
      case 1:
        print('View staff');
        break;
      case 2:
        print('Add new staff');
        break;
      case 3:
        print('Edit staff');
        break;
      default:
        print('Please enter a valid option');
        break;
    }
  } while (option != 0);
}