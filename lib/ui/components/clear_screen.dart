import 'dart:io';

/// Clear the terminal screen. This uses a simple ANSI escape sequence.
/// Wrapped in try/catch to avoid throwing when stdout is unavailable.
void clearScreen() {
  try {
    stdout.write('\x1B[2J\x1B[0;0H');
  } catch (_) {
    // Ignore any write errors (e.g., when stdout is closed or redirected).
  }
}
