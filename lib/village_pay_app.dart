import 'package:village_pay/exports.dart';

class VillagePayApp extends StatelessWidget {
  const VillagePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCheckerCubit()),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
