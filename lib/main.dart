import 'package:hospital_management_system/ui/components/loading_bar.dart';
import 'package:hospital_management_system/ui/hospital_console.dart';

Future<void> main() async {
  HospitalConsole console = HospitalConsole();
  await loadingBar();
  console.start();
}