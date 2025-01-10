import 'package:village_pay/exports.dart';

enum AuthStates { loadingState, loggedInState, loggedOutState }

class LoginCheckerCubit extends Cubit<AuthStates> {
  LoginCheckerCubit() : super(AuthStates.loadingState);

  /// Emits loggedOutState if firebase currentUser is null,
  /// otherwise emits loggedInState
  void checkUserAuth() async {
    await Future.delayed(Duration.zero);

    SharedPreferences prefs = locator<SharedPreferences>();
    String? loggedInUserId =
        prefs.getString(SharedPrefsConstants.loggedInVillagerId);

    emit(loggedInUserId != null
        ? AuthStates.loggedInState
        : AuthStates.loggedOutState);
  }

  void signOutUser() async {
    SharedPreferences prefs = locator<SharedPreferences>();
    await prefs.clear();
    emit(AuthStates.loggedOutState);
    Navigator.of(navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
  }
}
