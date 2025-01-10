import 'package:village_pay/exports.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);
}
