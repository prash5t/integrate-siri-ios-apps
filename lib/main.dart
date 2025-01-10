import 'package:village_pay/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const VillagePayApp());
}
