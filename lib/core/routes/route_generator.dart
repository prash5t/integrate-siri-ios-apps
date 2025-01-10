import 'package:village_pay/exports.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Object? argument = settings.arguments;

  switch (settings.name) {
    case AppRoutes.loginCheckerScreen:
      return CupertinoPageRoute(
          builder: (context) => const LoginCheckerScreen());
    case AppRoutes.loginScreen:
      return CupertinoPageRoute(builder: (context) => const LoginScreen());
    case AppRoutes.villagersScreen:
      return CupertinoPageRoute(builder: (context) => const VillagersScreen());
    default:
      return CupertinoPageRoute(
          builder: (context) => const LoginCheckerScreen());
  }
}
