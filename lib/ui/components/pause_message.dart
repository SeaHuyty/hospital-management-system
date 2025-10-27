import 'dart:io';

void pressEnterToContinue() {
  try {
    stdout.write('\nPress Enter to continue...');
    // Use synchronous read so interactive runs block here. Wrap in try/catch
    // because stdin may be closed or unavailable in some execution contexts
    // (causing a StateError or OSError).
    try {
      stdin.readLineSync();
    } catch (_) {
      // If stdin isn't available, swallow the error and continue.
    }
  } catch (_) {
    // If stdout isn't available or has been redirected/closed, ignore errors
    // to avoid crashing the app (e.g., when running in non-interactive tests).
  }
}
