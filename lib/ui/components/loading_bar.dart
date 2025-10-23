import 'dart:io';
import './clear_screen.dart';

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