import 'package:hospital_management_system/ui/hospital_console.dart';

Future<void> main() async {
  HospitalConsole console = HospitalConsole();
  await console.loadingBar();
  console.start();
}