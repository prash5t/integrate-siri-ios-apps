import 'package:village_pay/exports.dart';

class LoginCheckerScreen extends StatefulWidget {
  const LoginCheckerScreen({super.key});

  @override
  State<LoginCheckerScreen> createState() => _LoginCheckerScreenState();
}

class _LoginCheckerScreenState extends State<LoginCheckerScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCheckerCubit>(context).checkUserAuth();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCheckerCubit, AuthStates>(
      listener: (context, state) {
        if (state == AuthStates.loggedInState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.villagersScreen, (route) => false);
        } else if (state == AuthStates.loggedOutState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
        }
      },
      child: const CupertinoPageScaffold(
        child: Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
