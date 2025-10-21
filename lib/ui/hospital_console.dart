import 'dart:io';
import 'dart:async';

class HospitalConsole {
  void clearScreen() {
    stdout.write('\x1B[2J\x1B[0;0H');
  }

  Future<void> loadingBar() async {
    const int total = 50; // length of the bar
    clearScreen();
    print("\n\n\n\n\n");
    for (int i = 0; i <= 100; i += 4) {
      // Calculate progress
      int filled = (i / 100 * total).round();
      String bar = '█' * filled + '-' * (total - filled);

      // Move cursor to beginning of line and rewrite the bar
      stdout.write('\r\t\t\t\tLoading: $bar $i%');

      await Future.delayed(const Duration(milliseconds: 100));
    }
    clearScreen();
  }

  void start() {
    int? choice;

    do {
      print("\n\n\t\t\t\t=============================================\n");
      print("\t\t\t\t\tHOSPITAL MANAGEMENT SYSTEM\t\n");
      print("\t\t\t\t\t1. Staff");
      print("\t\t\t\t\t2. Room");
      print("\t\t\t\t\t0. Exit program");
      print("\n\t\t\t\t=============================================\n");

      stdout.write("\t\t\t\tEnter your choice: ");
      String? input = stdin.readLineSync();

      // Try parsing the input
      choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          //
          break;
        case 2:
          //
          break;
        case 0:
          //
          break;
        default:
          print("\n\t\t\t\tInvalid choice! Please try again.");
          continue;
      }
    } while (choice != 0);
  }
}
