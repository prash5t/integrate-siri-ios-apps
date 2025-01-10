import 'package:village_pay/exports.dart';

class VillagePayApp extends StatelessWidget {
  const VillagePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCheckerCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => GetVillagersCubit()),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemBlue,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
          barBackgroundColor: CupertinoColors.systemBackground,
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.systemBlue,
            textStyle: TextStyle(
              fontFamily: '.SF Pro Text',
              fontSize: 17,
              color: CupertinoColors.label,
            ),
          ),
        ),
        onGenerateRoute: onGenerateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
